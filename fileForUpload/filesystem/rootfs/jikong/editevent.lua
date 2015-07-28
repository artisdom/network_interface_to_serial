--[[
***************************************************************************

                                        ��Ȩ���� (C), 2001-2020, ���������ſƼ��ɷ����޹�˾

***************************************************************************
     ��Ŀ           : �������Լ�������
     ����           : ���Ӹ�
     �������� : 2014-03-19

     �汾           : 1.0
     �������� : 
                              

***************************************************************************        
--]]


--[[

  ��̽ӿ�

  serial.open(serial_no, baud_rate, data_bits, parity, stop_bit)
  serial.close(serial_no)
  serial.send(serial_no, data)
  
  infrared.send(infrared_no, rec_no)
  
  relay.open(relay_no)
  relay.close(relay_no)
  
  wol.send(mac_addr, password)
  http.send(url)
  onvif.send(http_uri, http_body)
  
  telnet.open(telnet_no, ipaddr, port)
  telnet.send(telnet_no, data)
  telnet.close(telnet_no)
  
  ui.show(ctrl_id)
  ui.hide(ctrl_id)
  ui.enable(ctrl_id)
  ui.disable(ctrl_id)
  
  slider.setvalue(ctrl_id, value)
  progress.setvalue(ctrl_id, value)
  radio.check(ctrl_id, true|false)
  checkbox.check(ctrl_id, true|false)

  ����
  ACTION_CLICK
  ACTION_PRESSED
  ACTION_RELEASED
  ACTION_DOUBLE_CLICK
  ACTION_SLIDER_CHANGED
--]]


-- ��ȡvalue�ڱ�tab�е�����
local function get_index_in_table(tab, value)
	if type(tab) ~= "table" then
		return 0;
	end
		
	for k = 1, table.maxn(tab) do
		if tab[k] == value then
			return k;
		end
	end
	return 0;
end



-- --------------------  ���ڲ���     --------------------
local ctrl_id_test_serial  = {17,18,19,20,21,22,23,24};   
function function_serial_test(ctrl_id)

  -- ����İ�ť˳��תΪ���ڵı��
	local serial_no = get_index_in_table(ctrl_id_test_serial, ctrl_id);
	
	if serial_no >= 1 and  serial_no <= 8 then
	
	   -- ����һЩ�ַ�
	   local buffer = string.format("this is from serial %d\r\n", serial_no);
	   serial.send(serial_no, buffer)
  end
end


-- --------------------  ����ӿڲ���     --------------------
local ctrl_id_test_infrared  = {27,28,29,30,31,32,33,34};       
function function_infrared_test(ctrl_id)

  -- ����İ�ť˳��תΪ����˿ڵı��
	local infrared_no = get_index_in_table(ctrl_id_test_infrared, ctrl_id);
		
	if infrared_no >= 1 and  infrared_no <= 8 then
	
	   -- �̶��������ݿ�ĵ�һ����¼
	   infrared.send(infrared_no, 1)
	end
end


-- --------------------  �̵�ӿڲ���     -------------------- 
local ctrl_id_test_relay_on  = {45,35,36,37,38,39,40,41};          
function function_relay_on_test(ctrl_id)

  -- ����İ�ť˳��תΪ�̵�˿ڵı��
	local relay_no = get_index_in_table(ctrl_id_test_relay_on, ctrl_id);
		
	if relay_no >= 1 and  relay_no <= 8 then
	  relay.open(relay_no);   -- �򿪼̵�
  end
end

local ctrl_id_test_relay_off  = {46,42,43,47,48,49,50,51};
function function_relay_off_test(ctrl_id)

	-- ����İ�ť˳��תΪ�̵�˿ڵı��
	local relay_no = get_index_in_table(ctrl_id_test_relay_off, ctrl_id);
	
	if relay_no >= 1 and  relay_no <= 8 then
	   relay.close(relay_no);   -- �رռ̵�
	end
end





-- ����ؼ��ϵĵ�������
local function control_action_click(ctrl_id)
  -- ����
  if     17  == ctrl_id then function_serial_test(ctrl_id);
  elseif 18  == ctrl_id then function_serial_test(ctrl_id);
  elseif 19  == ctrl_id then function_serial_test(ctrl_id);
  elseif 20  == ctrl_id then function_serial_test(ctrl_id);
  elseif 21  == ctrl_id then function_serial_test(ctrl_id);
  elseif 22  == ctrl_id then function_serial_test(ctrl_id);
  elseif 23  == ctrl_id then function_serial_test(ctrl_id);
  elseif 24  == ctrl_id then function_serial_test(ctrl_id);
  
  -- ����ӿ�
  elseif 27  == ctrl_id then function_infrared_test(ctrl_id);
  elseif 28  == ctrl_id then function_infrared_test(ctrl_id);
  elseif 29  == ctrl_id then function_infrared_test(ctrl_id);
  elseif 30  == ctrl_id then function_infrared_test(ctrl_id);
  elseif 31  == ctrl_id then function_infrared_test(ctrl_id);
  elseif 32  == ctrl_id then function_infrared_test(ctrl_id);
  elseif 33  == ctrl_id then function_infrared_test(ctrl_id);
  elseif 34  == ctrl_id then function_infrared_test(ctrl_id);
  
  -- �̵�ӿ�
  elseif 45  == ctrl_id then function_relay_on_test(ctrl_id);
  elseif 35  == ctrl_id then function_relay_on_test(ctrl_id);
  elseif 36  == ctrl_id then function_relay_on_test(ctrl_id);
  elseif 37  == ctrl_id then function_relay_on_test(ctrl_id);
  elseif 38  == ctrl_id then function_relay_on_test(ctrl_id);
  elseif 39  == ctrl_id then function_relay_on_test(ctrl_id);
  elseif 40  == ctrl_id then function_relay_on_test(ctrl_id);
  elseif 41  == ctrl_id then function_relay_on_test(ctrl_id);
  
  elseif 46  == ctrl_id then function_relay_off_test(ctrl_id);
  elseif 42  == ctrl_id then function_relay_off_test(ctrl_id);
  elseif 43  == ctrl_id then function_relay_off_test(ctrl_id);
  elseif 47  == ctrl_id then function_relay_off_test(ctrl_id);
  elseif 48  == ctrl_id then function_relay_off_test(ctrl_id);
  elseif 49  == ctrl_id then function_relay_off_test(ctrl_id);
  elseif 50  == ctrl_id then function_relay_off_test(ctrl_id);
  elseif 51  == ctrl_id then function_relay_off_test(ctrl_id);
  end
end



--[[
**********************************************************
 
                                                                 ��̽ӿ�
  
**********************************************************
--]]
-- ��ʼ��  
function initialize()
  serial.open(1, 115200, 8, "N", 1);
  serial.open(2, 115200, 8, "N", 1);
  serial.open(3, 115200, 8, "N", 1);
  serial.open(4, 115200, 8, "N", 1);
  serial.open(5, 115200, 8, "N", 1);
  serial.open(6, 115200, 8, "N", 1);
  serial.open(7, 115200, 8, "N", 1);
  serial.open(8, 115200, 8, "N", 1);
end
-- ����ʼ��
function uninitialize()
  
end
-- ���ݽ���Ķ���������Ӧ������
function ui_event(ui_id, event, data)
  if     UI_EVENT_CLICK    == event then control_action_click(ui_id);
  end
end
-- ��ȡ�豸�ķ�����
function response_data(port_type, port_no, data)
  --print(string.format("lua->response_data port_type = %d, port_no = %d, data length = %d", port_type, port_no, string.len(data)));
end