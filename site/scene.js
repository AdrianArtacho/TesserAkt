/* Shared visual metaphor; no MIDI, audio, storage, imports or network requests. */
(() => {
  'use strict';
  const root = document.querySelector('[data-instrument]');
  if (!root) return;
  const canvas = root.querySelector('canvas'), ctx = canvas.getContext('2d');
  const buttons = [...root.querySelectorAll('[data-layer]')];
  const motionButton = root.querySelector('[data-motion]');
  const pulseButton = root.querySelector('[data-pulse]');
  const title = root.querySelector('[data-layer-title]');
  const description = root.querySelector('[data-layer-description]');
  const params = new URLSearchParams(location.search), token = params.get('prlToken');
  const embedded = window.parent !== window;
  const reduced = matchMedia('(prefers-reduced-motion: reduce)');
  const colours = ['#d5ff5f', '#63d8ff', '#bb9bff', '#ff9e6b'];
  const labels = [
    ['Operators · transform an event', 'Elementary MIDI operations: delay, mirror, scale, select or trigger.'],
    ['Bridges · connect different worlds', 'Translate and connect MIDI, OSC, sensors, notation and visual systems.'],
    ['Morphisms · articulate relationships', 'Shape transformations into patterns, gestures and structures over time.'],
    ['Agents · organise behaviour', 'Cue, prompt, repeat and coordinate processes across a performance.']
  ];
  // The 16 vertices and 32 edges of a tesseract; colour denotes edge dimension.
  const vertices = Array.from({length:16}, (_,i) => [0,1,2,3].map(d => (i >> d & 1) ? 1 : -1));
  const edges = [];
  vertices.forEach((_,i) => { for(let d=0;d<4;d++) { const j=i^(1<<d); if(j>i) edges.push([i,j,d]); } });
  let selected=0, phase=.65, pulse=0, width=320, height=300, raf=0, previous=0;
  let motion=!reduced.matches && params.get('motion')!=='off';
  let parentActive=params.get('motion')!=='off', inView=true, pointerX=0, pointerY=0;
  function rotate(v,a,b,t){const x=v[a],y=v[b];v[a]=x*Math.cos(t)-y*Math.sin(t);v[b]=x*Math.sin(t)+y*Math.cos(t);}
  function project(v){
    const p=[...v];
    rotate(p,0,3,phase*.31); rotate(p,1,2,.45+phase*.19);
    rotate(p,0,2,.5+pointerX*.35); rotate(p,1,3,.25+pointerY*.25);
    const w=3.5/(3.5-p[3]), z=5/(5-p[2]*w);
    return [p[0]*w*z,p[1]*w*z,p[2]];
  }
  function draw(){
    if(!ctx)return;
    ctx.clearRect(0,0,width,height);
    const projected=vertices.map(project);
    const scale=Math.min(width*.41/Math.max(...projected.map(p=>Math.abs(p[0]))),height*.41/Math.max(...projected.map(p=>Math.abs(p[1]))));
    const points=projected.map(p=>[width/2+p[0]*scale,height/2+p[1]*scale,p[2]]);
    // Quiet reference axes keep the moving projection spatially legible.
    ctx.strokeStyle='#48536444';ctx.lineWidth=1;ctx.setLineDash([2,6]);
    ctx.beginPath();ctx.moveTo(width/2,16);ctx.lineTo(width/2,height-16);ctx.moveTo(16,height/2);ctx.lineTo(width-16,height/2);ctx.stroke();ctx.setLineDash([]);
    for(const [a,b,d] of [...edges].sort((u,v)=>(u[2]===selected)-(v[2]===selected))){
      const p=points[a],q=points[b],focus=d===selected;
      ctx.globalAlpha=focus?.9:.23;ctx.strokeStyle=colours[d];ctx.lineWidth=focus?1.8:1;
      ctx.beginPath();ctx.moveTo(p[0],p[1]);ctx.lineTo(q[0],q[1]);ctx.stroke();
      if(focus){
        const t=((phase*.32+a*.071)%1+1)%1;
        const x=p[0]+(q[0]-p[0])*t,y=p[1]+(q[1]-p[1])*t;
        ctx.globalAlpha=.95;ctx.fillStyle=colours[d];ctx.beginPath();ctx.arc(x,y,2.2+pulse*1.6,0,Math.PI*2);ctx.fill();
      }
    }
    ctx.globalAlpha=1;
    for(const p of points){ctx.fillStyle='#eaf0ff';ctx.beginPath();ctx.arc(p[0],p[1],2,0,Math.PI*2);ctx.fill();}
    if(pulse>0){ctx.strokeStyle=colours[selected];ctx.globalAlpha=pulse*.3;ctx.lineWidth=1;ctx.beginPath();ctx.arc(width/2,height/2,(1-pulse)*Math.min(width,height)*.65+12,0,Math.PI*2);ctx.stroke();ctx.globalAlpha=1;}
  }
  function running(){return !!ctx && motion && parentActive && inView && !document.hidden;}
  function frame(t){
    raf=0;if(!running())return;
    if(!previous)previous=t;
    const delta=t-previous;
    if(delta>=1000/30){const dt=Math.min(delta,70)/1000;phase+=dt*.52;pulse=Math.max(0,pulse-dt*.8);previous=t;draw();}
    raf=requestAnimationFrame(frame);
  }
  function sync(){
    cancelAnimationFrame(raf);raf=0;previous=0;
    motionButton.textContent=motion?'Pause motion':'Enable motion';
    motionButton.setAttribute('aria-pressed',String(motion));
    motionButton.disabled=embedded&&!parentActive;
    draw();if(running())raf=requestAnimationFrame(frame);
  }
  function reportSize(){if(embedded)parent.postMessage({type:'prl:resize',token,height:Math.ceil(document.body.getBoundingClientRect().height)},'*');}
  function resize(){
    width=Math.max(1,canvas.clientWidth);height=Math.max(1,canvas.clientHeight);
    const ratio=Math.min(window.devicePixelRatio||1,1.75);
    canvas.width=Math.round(width*ratio);canvas.height=Math.round(height*ratio);
    if(ctx)ctx.setTransform(ratio,0,0,ratio,0,0);draw();reportSize();
  }
  buttons.forEach(button=>button.addEventListener('click',()=>{
    selected=Number(button.dataset.layer);
    buttons.forEach(b=>b.setAttribute('aria-pressed',String(b===button)));
    title.textContent=labels[selected][0];title.style.color=colours[selected];description.textContent=labels[selected][1];draw();reportSize();
  }));
  pulseButton.addEventListener('click',()=>{pulse=1;phase+=.3;draw();});
  motionButton.addEventListener('click',()=>{motion=!motion;sync();});
  canvas.addEventListener('pointermove',event=>{
    if(!running()||reduced.matches)return;
    const rect=canvas.getBoundingClientRect();pointerX=(event.clientX-rect.left)/rect.width-.5;pointerY=(event.clientY-rect.top)/rect.height-.5;
  });
  canvas.addEventListener('pointerleave',()=>{pointerX=0;pointerY=0;});
  window.addEventListener('message',event=>{
    if(!embedded||!token||event.source!==parent||event.data?.token!==token||event.data.type!=='prl:visibility'||typeof event.data.active!=='boolean')return;
    parentActive=event.data.active;sync();
  });
  reduced.addEventListener('change',()=>{if(reduced.matches)motion=false;sync();});
  document.addEventListener('visibilitychange',sync);
  window.addEventListener('pagehide',()=>{cancelAnimationFrame(raf);raf=0;});
  window.addEventListener('pageshow',sync);
  if('ResizeObserver' in window)new ResizeObserver(resize).observe(root);else window.addEventListener('resize',resize);
  if('IntersectionObserver' in window)new IntersectionObserver(entries=>{inView=entries[0].isIntersecting;sync();},{threshold:0}).observe(root);
  if(!ctx){canvas.hidden=true;pulseButton.disabled=true;motionButton.hidden=true;}
  resize();sync();
  if(embedded)parent.postMessage({type:'prl:ready',token},'*');
})();
