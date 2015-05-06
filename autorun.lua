stm32f4.ws2812.init(1)

speed = 1
brightness = 10
colors = {0, 0.5, 1}
cyclelen = 6000
ledcount = 60

function limit( val, min, max )
	if val > max then return max
	elseif val < min then return min
	else return val
	end
end

function led_cycle_func (idx,loffset) 
	theta = (idx-loffset*speed)/ledcount*math.pi
	return (math.sin(theta)+1)*brightness
end

co = coroutine.create( function ()
		while true do
			for offset=1,cyclelen do
				leds = ''
				for i=1,ledcount do
					val = led_cycle_func( i, offset )
					leds = leds .. string.char(limit(val*colors[1],0,255), limit(val*colors[2],0,255), limit(val*colors[3],0,255))
				end
				stm32f4.ws2812.writergb( pio.PB_7, leds )
				coroutine.yield()
			end
		end
	end )

handle = rpc.listen(1,tmr.SYS_TIMER)
uart.set_buffer(1, 128)

while true do
   if rpc.peek( handle ) then
      rpc.dispatch( handle )
   end
   coroutine.resume( co )
end