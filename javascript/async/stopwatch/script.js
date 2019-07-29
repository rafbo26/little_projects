const startBtn = document.querySelector('#start');
const stopBtn = document.querySelector('#stop');
const resetBtn = document.querySelector('#reset');
let p = document.querySelector('p');
let stopwatch = 0;
let interval;

startBtn.addEventListener('click', foo);
stopBtn.addEventListener('click', stop);
resetBtn.addEventListener('click', reset);

function foo() {
  clearInterval(interval);
  interval = setInterval(start, 1000);
}

function start() {
  p.textContent = toTime(++stopwatch);
}

function stop() {
  clearInterval(interval);
}

function reset() {
  stop();
  stopwatch = 0;
  p.textContent = toTime(stopwatch);
}

function toTime(num) {
  let hours = 0;
  let minutes = 0;
  let seconds = 0;
  let time = num;
  let timeString = '';

  hours = Math.floor(time / 3600);
  time = time - hours * 3600;
  minutes = Math.floor(time / 60);
  time = time - minutes * 60;
  seconds = time;

  minutes = minutes < 10 ? `0${minutes}` : minutes;
  seconds = seconds < 10 ? `0${seconds}` : seconds;
  timeString = `${hours}:${minutes}:${seconds}`;

  return timeString;
}
