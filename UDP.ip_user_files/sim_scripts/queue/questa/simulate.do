onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib queue_opt

do {wave.do}

view wave
view structure
view signals

do {queue.udo}

run -all

quit -force
