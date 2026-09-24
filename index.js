var cur = document.querySelector("#cur")
var cb = document.querySelector("#cb")
document.addEventListener("mousemove",function(dets){
  cur.style.left = dets.x -12.5 + "px"
  cur.style.top = dets.y -12.5   + "px"
})
document.addEventListener("mousemove", function(dets){
  cb.style.left = dets.x - 150 + "px"
  cb.style.top = dets.y -150 + "px"
})

gsap.to("#nav",{
  backgroundColor:"#000",
  duration:0.5,
  height:"130px",
  scrollTrigger:{
    trigger:"#nav",
    scroller:"body",
    markers:true,
    start:"top -1%",
    end:"top -2",
    scrub:3,
  }
})

gsap.to("#main",{
    backgroundColor:"#000",
    scrollTrigger:{
      trigger:"#main",
      scroller:"body",
      markers:true,
      start:"top -25%",
      end:"top -70%",
      scrub:2,
    }
})
