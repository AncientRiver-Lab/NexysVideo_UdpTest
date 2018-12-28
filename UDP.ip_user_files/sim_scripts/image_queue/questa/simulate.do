onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib image_queue_opt

do {wave.do}

view wave
view structure
view signals

do {image_queue.udo}

run -all

quit -force
