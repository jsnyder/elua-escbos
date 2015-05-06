function error_handler (message)
	io.write ("MY ERROR: " .. message .. "\n");
end

rpc.on_error (error_handler);

slave,err = rpc.connect ("/dev/tty.usbmodem1423");

print("Platform: " .. slave.pd.platform())
print("CPU: " .. slave.pd.cpu())
print("Board: " .. slave.pd.board())
print("CPU Clock: " .. slave.cpu.clock()/1000000 .. " MHz")


function led_cycle_func_tan (idx,loffset) 
	theta = (idx-loffset*speed)/ledcount*math.pi*0.5
	return (math.sin(theta)/math.cos(theta))*brightness
end

function led_cycle_func_sin (idx,loffset) 
	theta = (idx-loffset*speed)/ledcount*math.pi*2
	return (math.sin(theta)+1)*brightness
end

function led_cycle_func_single (idx,loffset)
	if ( ( loffset - idx ) % ledcount == 0 ) then
		return 255
	else
		return 0
	end
end

function led_cycle_func_block (idx,loffset)
	if ( ( loffset - idx ) % ledcount < 20 ) then
		return 255
	else
		return 0
	end
end

-- slave.led_cycle_func = led_cycle_func_single
-- slave.led_cycle_func = led_cycle_func_block
-- slave.led_cycle_func = led_cycle_func_sin
-- slave.led_cycle_func = led_cycle_func_tan
-- slave.colors = {1,0,0}
-- slave.speed = 3