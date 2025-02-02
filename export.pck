GDPC                �
                                                                      #   P   res://.godot/exported/133200997/export-234ad4d8d43f2f55834435b9887da50b-main.res�=      +      �3d(Ƭ��ZX��q    P   res://.godot/exported/133200997/export-3070c538c03ee49b7677ff960a3f5195-main.scn�>      3$      ����ʫ.@z�@�u    T   res://.godot/exported/133200997/export-a6f81c412b20438573249a6edd862784-AntQueen.scn�      �      ǜE?8[�O��r'a�    P   res://.godot/exported/133200997/export-b2ba060bfcfa8c6297b3f1ea3316703f-Ant.scn �      c      �̶��	L�e�u���    X   res://.godot/exported/133200997/export-c5faa904c52fa0da12dd478d31fc19cb-healthbar.scn   �      �
      Zs��!��I6��\j    X   res://.godot/exported/133200997/export-ef07071e4e345ee172aa3410c860e2fa-ant_graphic.scn @�      &      �G�RnU�pp���)�    ,   res://.godot/global_script_class_cache.cfg  ��      �       �p�|�I���7f    X   res://.godot/imported/Minecraftia-Regular.ttf-0fa89177c20e22423e9c17d6458d6166.fontdata 0c      e      ��։U4�H�t6�&-�    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex�      �      �̛�*$q�*�́        res://.godot/uid_cache.bin  0�      �       nC�Ԁ�E��r�hߙ       res://Ant.gd        �       �f'Y�[07�K���/       res://Ant.tscn.remap��      `       @�>���׭� 4�       res://AntFollow.gd  `�      �       �̃AMŃ�C�gnz       res://AntQueen.gd         y       .�m;��[=�f9��%       res://AntQueen.tscn.remap   P�      e       *�t�������L0N       res://DistanceLabel.gd  ��      g       %�0�)��(^  ԟA       res://Food.gd   ��      �      ���T} DI��B#�h       res://FoodLabel.gd  P�      u       ��C�%\�j{o\� #g       res://ForageLabel.gdP      �      1�6M�	��juVz�    $   res://Minecraftia-Regular.ttf.importP�      �       �JA���H�/qV��       res://NewsHandler.gd�      N       ��9�F:y�����|<�       res://NewsLabel.gd  ��      9      �.t.�:u��Pu����       res://PopLabel.gd    �      �       �k4y('_:�<�f�       res://Score.gd  @�      s       b���M�Jɢ�8e       res://WeatherLabel.gd   ��      $       ��6{Y�A(y̜i۴       res://ant_graphic.gdp�      ^      �O*��_�1w�S,       res://ant_graphic.tscn.remap�      h       �������(F��H��       res://healthbar.gd  �      �       ����'��D�nk����       res://healthbar.tscn.remap  ��      f       ꪏ�@%p��*�	���\       res://icon.svg  p�      �      C��=U���^Qu��U3       res://icon.svg.import   �%      �        5�;l�vT﷋�����       res://main.gd   p&      B      R��Ð�C=Ipz*�z�       res://main.tres.remap   0�      a       ���(���R+6���       res://main.tscn.remap   ��      a       �J�Sw� ������       res://project.binary0�      y      ཌ+Y6�[���|M    ��
�extends Node
class_name Ant



enum {
	STATE_IDLE,
	STATE_LEAVE,
	STATE_RETURN,
}


var age = 0
var MAX_HEALTH = 25
var health = 1
var state = STATE_IDLE

func _ready():
	health = MAX_HEALTH


var rate = 0.5
func do_frame():
	age += 1
	health -= abs(randf_range(0, 2*rate))
	
	if health <= 0:
		die()

func die():
	NewsHandler.broadcast("An ant just died...")
	queue_free()


func set_state(s: int):
	state = s
V�b�RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://Ant.gd ��������      local://PackedScene_vmdm7          PackedScene          	         names "         Ant    script    Node    	   variants                       node_count             nodes     	   ��������       ����                    conn_count              conns               node_paths              editable_instances              version             RSRC���:@�^ѩ�extends Ant
class_name AntQueen

func _init():
	MAX_HEALTH = 70

signal gameover(i: int)
func die():
	gameover.emit(age)
���W��RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       PackedScene    res://Ant.tscn @�H��3    Script    res://AntQueen.gd ��������      local://PackedScene_0fu7v 4         PackedScene          
         names "      	   AntQueen    script    	   variants                                node_count             nodes     	   �����������    ����                   conn_count              conns               node_paths              editable_instances              base_scene              version             RSRCS8����2��extends Label

var dots = 0
enum FORAGING {IDLE, LEAVE, RETURN, RETURN_DONE, FOUND,
KILLING, KILLING_DONE,
EATING, EATING_DONE,
INVEST, INVEST_DONE,
TOO_HEAVY_TO_KILL, TOO_HEAVY_TO_CARRY, DEAD, GAMEOVER}
var state = 0

func _on_tick_timer_timeout():
	
	match state:
		FORAGING.LEAVE:
			text = "Currently foraging"
		FORAGING.FOUND:
			text = "Found food."
		FORAGING.INVEST:
			text = "Identifying food"
		FORAGING.INVEST_DONE:
			text = "It's a %smg %s! " % [round(%Food.my_weight), %Food.type]
			if %Food.my_alive: text += "It's alive!"
			else: text += "It's dead."
		FORAGING.KILLING:
			text = "Killing the %s" % %Food.type
		FORAGING.KILLING_DONE:
			text = "Killed the %s!" % %Food.type
		FORAGING.EATING:
			text = "Foragers eating %s" % %Food.type
		FORAGING.EATING_DONE:
			text = "Foragers ate some %s." % %Food.type
		FORAGING.RETURN:
			if %Food.get_null():
				text = "Returning empty-handed"
			else:
				text = "Carrying the %s home" % %Food.type
		FORAGING.RETURN_DONE:
			if %Food.get_null():
				text = "Returned."
			else:
				text = "Returned with %s!" % %Food.type
		FORAGING.TOO_HEAVY_TO_CARRY:
			text = "It's too heavy to carry."
		FORAGING.TOO_HEAVY_TO_KILL:
			text = "It's too big to kill."
		FORAGING.DEAD:
			text = "All foragers died..."
		FORAGING.GAMEOVER:
			text = "QUEEN STARVED. GAME OVER"
		
		
	if text != "":
		if !(text[-1] in ["!","."]):
			dots += 1
			dots %= 4
			for i in dots: text += "."
��extends Control

var MAX := 100
var value := 50

func _physics_process(delta):
	$ProgressBar.max_value = MAX
	$ProgressBar.value = value
	$ProgressBar/Value.text = "%s/%s" % [int(value),int(MAX)]

func set_stats(v: float, m: float):
	MAX = m
	value = v
�S�RSRC                    PackedScene            ��������                                            .      resource_local_to_scene    resource_name    font_names    font_italic    font_weight    font_stretch    antialiasing    generate_mipmaps    allow_system_fallback    force_autohinter    hinting    subpixel_positioning #   multichannel_signed_distance_field    msdf_pixel_range 
   msdf_size    oversampling 
   fallbacks    script    content_margin_left    content_margin_top    content_margin_right    content_margin_bottom 	   bg_color    draw_center    skew    border_width_left    border_width_top    border_width_right    border_width_bottom    border_color    border_blend    corner_radius_top_left    corner_radius_top_right    corner_radius_bottom_right    corner_radius_bottom_left    corner_detail    expand_margin_left    expand_margin_top    expand_margin_right    expand_margin_bottom    shadow_color    shadow_size    shadow_offset    anti_aliasing    anti_aliasing_size 	   _bundled       Script    res://healthbar.gd ��������      local://SystemFont_2q8ku �         local://StyleBoxFlat_40t5f          local://StyleBoxFlat_u6vcd L         local://PackedScene_sdyrj �         SystemFont                                StyleBoxFlat          ���=���=���=  �?         StyleBoxFlat          ��?���>      �?#                  PackedScene    -      	         names "      
   Healthbar    layout_mode    anchors_preset    offset_right    offset_bottom    script    Control    RichTextLabel    offset_left    offset_top +   theme_override_font_sizes/normal_font_size    text    scroll_active    ProgressBar !   theme_override_colors/font_color    theme_override_fonts/font $   theme_override_font_sizes/font_size !   theme_override_styles/background    theme_override_styles/fill    value    Value    horizontal_alignment    Label    	   variants                          B               �@      @     C     B            Health             �B     �@     ?C     0A                                                          HB      �     �B     pA      34596/434375943       node_count             nodes     Z   ��������       ����                                                    ����               	                  
         	      
                     ����               	                                                                       ����         	                                              conn_count              conns               node_paths              editable_instances              version             RSRC�GST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /������!"2�H�$�n윦���z�x����դ�<����q����F��Z��?&,
ScI_L �;����In#Y��0�p~��Z��m[��N����R,��#"� )���d��mG�������ڶ�$�ʹ���۶�=���mϬm۶mc�9��z��T��7�m+�}�����v��ح�m�m������$$P�����එ#���=�]��SnA�VhE��*JG�
&����^x��&�+���2ε�L2�@��		��S�2A�/E���d"?���Dh�+Z�@:�Gk�FbWd�\�C�Ӷg�g�k��Vo��<c{��4�;M�,5��ٜ2�Ζ�yO�S����qZ0��s���r?I��ѷE{�4�Ζ�i� xK�U��F�Z�y�SL�)���旵�V[�-�1Z�-�1���z�Q�>�tH�0��:[RGň6�=KVv�X�6�L;�N\���J���/0u���_��U��]���ǫ)�9��������!�&�?W�VfY�2���༏��2kSi����1!��z+�F�j=�R�O�{�
ۇ�P-�������\����y;�[ ���lm�F2K�ޱ|��S��d)é�r�BTZ)e�� ��֩A�2�����X�X'�e1߬���p��-�-f�E�ˊU	^�����T�ZT�m�*a|	׫�:V���G�r+�/�T��@U�N׼�h�+	*�*sN1e�,e���nbJL<����"g=O��AL�WO!��߈Q���,ɉ'���lzJ���Q����t��9�F���A��g�B-����G�f|��x��5�'+��O��y��������F��2�����R�q�):VtI���/ʎ�UfěĲr'�g�g����5�t�ۛ�F���S�j1p�)�JD̻�ZR���Pq�r/jt�/sO�C�u����i�y�K�(Q��7őA�2���R�ͥ+lgzJ~��,eA��.���k�eQ�,l'Ɨ�2�,eaS��S�ԟe)��x��ood�d)����h��ZZ��`z�պ��;�Cr�rpi&��՜�Pf��+���:w��b�DUeZ��ڡ��iA>IN>���܋�b�O<�A���)�R�4��8+��k�Jpey��.���7ryc�!��M�a���v_��/�����'��t5`=��~	`�����p\�u����*>:|ٻ@�G�����wƝ�����K5�NZal������LH�]I'�^���+@q(�q2q+�g�}�o�����S߈:�R�݉C������?�1�.��
�ڈL�Fb%ħA ����Q���2�͍J]_�� A��Fb�����ݏ�4o��'2��F�  ڹ���W�L |����YK5�-�E�n�K�|�ɭvD=��p!V3gS��`�p|r�l	F�4�1{�V'&����|pj� ߫'ş�pdT�7`&�
�1g�����@D�˅ �x?)~83+	p �3W�w��j"�� '�J��CM�+ �Ĝ��"���4� ����nΟ	�0C���q'�&5.��z@�S1l5Z��]�~L�L"�"�VS��8w.����H�B|���K(�}
r%Vk$f�����8�ڹ���R�dϝx/@�_�k'�8���E���r��D���K�z3�^���Vw��ZEl%~�Vc���R� �Xk[�3��B��Ğ�Y��A`_��fa��D{������ @ ��dg�������Mƚ�R�`���s����>x=�����	`��s���H���/ū�R�U�g�r���/����n�;�SSup`�S��6��u���⟦;Z�AN3�|�oh�9f�Pg�����^��g�t����x��)Oq�Q�My55jF����t9����,�z�Z�����2��#�)���"�u���}'�*�>�����ǯ[����82һ�n���0�<v�ݑa}.+n��'����W:4TY�����P�ר���Cȫۿ�Ϗ��?����Ӣ�K�|y�@suyo�<�����{��x}~�����~�AN]�q�9ޝ�GG�����[�L}~�`�f%4�R!1�no���������v!�G����Qw��m���"F!9�vٿü�|j�����*��{Ew[Á��������u.+�<���awͮ�ӓ�Q �:�Vd�5*��p�ioaE��,�LjP��	a�/�˰!{g:���3`=`]�2��y`�"��N�N�p���� ��3�Z��䏔��9"�ʞ l�zP�G�ߙj��V�>���n�/��׷�G��[���\��T��Ͷh���ag?1��O��6{s{����!�1�Y�����91Qry��=����y=�ٮh;�����[�tDV5�chȃ��v�G ��T/'XX���~Q�7��+[�e��Ti@j��)��9��J�hJV�#�jk�A�1�^6���=<ԧg�B�*o�߯.��/�>W[M���I�o?V���s��|yu�xt��]�].��Yyx�w���`��C���pH��tu�w�J��#Ef�Y݆v�f5�e��8��=�٢�e��W��M9J�u�}]釧7k���:�o�����Ç����ս�r3W���7k���e�������ϛk��Ϳ�_��lu�۹�g�w��~�ߗ�/��ݩ�-�->�I�͒���A�	���ߥζ,�}�3�UbY?�Ӓ�7q�Db����>~8�]
� ^n׹�[�o���Z-�ǫ�N;U���E4=eȢ�vk��Z�Y�j���k�j1�/eȢK��J�9|�,UX65]W����lQ-�"`�C�.~8ek�{Xy���d��<��Gf�ō�E�Ӗ�T� �g��Y�*��.͊e��"�]�d������h��ڠ����c�qV�ǷN��6�z���kD�6�L;�N\���Y�����
�O�ʨ1*]a�SN�=	fH�JN�9%'�S<C:��:`�s��~��jKEU�#i����$�K�TQD���G0H�=�� �d�-Q�H�4�5��L�r?����}��B+��,Q�yO�H�jD�4d�����0*�]�	~�ӎ�.�"����%
��d$"5zxA:�U��H���H%jس{���kW��)�	8J��v�}�rK�F�@�t)FXu����G'.X�8�KH;���[ ���TX	�f,�[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://rogds302conk"
path="res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex"
metadata={
"vram_texture": false
}
 extends Node2D

const STARTING_ANTS = 6

var foragers = 0
var time_to_change = 0

var stored_food = 50

enum WEATHER {CLEAR, RAIN, WIND}
var weather = WEATHER.CLEAR


enum FORAGING {IDLE, LEAVE, RETURN, RETURN_DONE, FOUND,
KILLING, KILLING_DONE,
EATING, EATING_DONE,
INVEST, INVEST_DONE,
TOO_HEAVY_TO_KILL, TOO_HEAVY_TO_CARRY, DEAD, GAMEOVER}
var foraging = FORAGING.IDLE

var distance_from_nest = 0

func _ready():
	for i in STARTING_ANTS:
		var new_ant = Ant.new()
		%Ants.add_child(new_ant)


func _physics_process(delta):
	
	var pop_health = get_pop_health()
	%HealthbarPop.set_stats(pop_health[0],pop_health[1])
	%HealthbarQueen.set_stats(%AntQueen.health, %AntQueen.MAX_HEALTH)
	%PopLabel.value = get_pop_size()
	%PopLabel.foragers = get_foragers().size()
	%DialogLabel.text = "Send %s to forage?" % foragers
	if foraging == FORAGING.IDLE:
		set_foragers(foragers)


func get_pop_size():
	return %Ants.get_child_count() - 1


func get_foragers() -> Array:
	return get_tree().get_nodes_in_group("Foragers")


func get_pop_health():
	
	var MAX_HEALTH = 0
	var health = 0
	
	for i in %Ants.get_children():
		if i != %AntQueen:
			MAX_HEALTH += i.MAX_HEALTH
			health += i.health
	
	return [health, MAX_HEALTH]


func do_tick():
	Score.update_score()
	%CurrentScoreLabel.text = "Score: %shr" % Score.score
	%HiScoreLabel.text = "Record: %shr" % Score.record
	
	
	for i in %Ants.get_children():
		i.do_frame()
		
		if not i in get_foragers():
			if stored_food > 0 and i.health < i.MAX_HEALTH-1:
				NewsHandler.broadcast("Nest eating well!")
				stored_food -= 1
				i.health += 1
		else:
			if foraging == FORAGING.EATING:
				if %Food.my_weight > 0 and i.health < i.MAX_HEALTH-1:
					NewsHandler.broadcast("Foragers eating!")
					%Food.my_weight -= 1
					i.health += 1
		stored_food = max(0, stored_food)
	
	time_to_change -= 1
	
	if foraging in [FORAGING.IDLE, FORAGING.GAMEOVER]:
		%DistanceLabel.hide()
	else:
		%DistanceLabel.show()
		if get_foragers().size() == 0:
			set_foraging(FORAGING.DEAD)
	
	match foraging:
		FORAGING.LEAVE:
			forage_for_food()
			distance_from_nest += 1
			%DistanceLabel.value = distance_from_nest
		FORAGING.INVEST:
			if time_to_change <= 0:
				set_foraging(FORAGING.INVEST_DONE)
		FORAGING.EATING:
			if time_to_change <= 0:
				set_foraging(FORAGING.EATING_DONE)
		FORAGING.RETURN:
			if time_to_change <= 0:
				set_foraging(FORAGING.RETURN_DONE)
			else:
				distance_from_nest = 4*time_to_change
				%DistanceLabel.value = distance_from_nest


func _on_button_plus_button_down():
	set_foragers(foragers + 1)


func _on_button_minus_button_down():
	set_foragers(foragers - 1)


func set_foragers(f: int):
	foragers = max(0, min(get_pop_size(), f))


func get_idle_ants():
	var out = []
	for i in %Ants.get_children():
		if i != %AntQueen:
			if i.state == i.STATE_IDLE:
				out.append(i)
	return out


func _on_button_ok_button_down():
	match foraging:
		FORAGING.IDLE:
			send_foragers()
		FORAGING.FOUND:
			set_foraging(FORAGING.INVEST)
		FORAGING.INVEST_DONE:
			
			if %Food.my_alive:
				if %Food.my_weight > foragers:
					set_foraging(FORAGING.TOO_HEAVY_TO_KILL)
				else:
					set_foraging(FORAGING.KILLING)
			else:
				set_foraging(FORAGING.EATING)
				
		FORAGING.EATING_DONE:
			
			if %Food.my_weight > foragers * 10:
				set_foraging(FORAGING.TOO_HEAVY_TO_CARRY)
			else:
			
				set_foraging(FORAGING.RETURN)
		
		FORAGING.TOO_HEAVY_TO_KILL:
			set_foraging(FORAGING.LEAVE)
		
		FORAGING.TOO_HEAVY_TO_CARRY:
			%Food.set_null()
			set_foraging(FORAGING.RETURN)
		
		FORAGING.RETURN_DONE:
			if !%Food.get_null():
				stored_food += %Food.my_weight
				%Food.set_null()
			stored_food += get_foragers().size() * 4
			set_foraging(FORAGING.IDLE)
			for i in get_foragers():
				i.set_state(i.STATE_IDLE)
				i.remove_from_group("Foragers")
		
		FORAGING.DEAD:
			set_foraging(FORAGING.IDLE)
			
		FORAGING.GAMEOVER:
			_on_queen_die()


func send_foragers():
	var idles = get_idle_ants()
	for i in foragers:
		idles[i].set_state(idles[i].STATE_LEAVE)
		idles[i].add_to_group("Foragers")
		set_foraging(FORAGING.LEAVE)
		%SendDialog.hide()
		%ForageLabel.show()
	%AntFollow.create_ants(true, foragers)
	calculate_time_to_change()


func calculate_time_to_change():
	time_to_change = 10


func forage_for_food():
	if time_to_change <= 0:
		set_foraging(FORAGING.FOUND)


func set_foraging(f: int):
	foraging = f
	%ForageLabel.state = f
	
	match f:
		FORAGING.IDLE:
			%ForageLabel.hide()
			%ButtonOK.show()
			%SendDialog.show()
		FORAGING.LEAVE:
			NewsHandler.broadcast("Brave foragers leave...")
			%ButtonOK.hide()
			time_to_change = 10
		FORAGING.FOUND:
			%ButtonOK.show()
		FORAGING.INVEST:
			NewsHandler.broadcast("Our girls found something!")
			%ButtonOK.hide()
			time_to_change = 5
		FORAGING.INVEST_DONE:
			%Food.initialize()
			%ButtonOK.show()
		FORAGING.EATING:
			%ButtonOK.hide()
			time_to_change = 5
		FORAGING.EATING_DONE:
			%ButtonOK.show()
		FORAGING.RETURN:
			NewsHandler.broadcast("The perilous %scm voyage..." % distance_from_nest)
			%ButtonOK.hide()
			time_to_change = distance_from_nest/4
		FORAGING.RETURN_DONE:
			%ButtonOK.show()
			%AntFollow.create_ants(false, foragers)
		FORAGING.DEAD:
			%ButtonOK.show()
		FORAGING.GAMEOVER:
			%ButtonOK.show()
			%SendDialog.hide()


func _on_weather_timer_timeout():
	var new = randi_range(0, 5)
	if new > 2:
		new = WEATHER.CLEAR
	if new != weather:
		%WeatherLabel.text = "Weather: %s" % WEATHER.keys()[new]
		weather = new
		for i in [%Rain, %Wind, %Leaves]: i.emitting=false
		if weather == WEATHER.RAIN:
			%Rain.emitting = true
		if weather == WEATHER.WIND:
			%Wind.emitting = true
			%Leaves.emitting = true


func _on_baby_timer_timeout():
	for i in randi_range(2,4):
		%Ants.add_child(Ant.new())
	NewsHandler.broadcast("Our queen had babies!")


func _on_queen_die():
	Score.score = 0
	get_tree().change_scene_to_file("res://main.tscn")


func _on_ant_queen_gameover(i):
	set_foraging(FORAGING.GAMEOVER)
�f�sz~��ްX�$�RSRC                    Theme            ��������                                                  resource_local_to_scene    resource_name    default_base_scale    default_font    default_font_size    script           local://Theme_yeoqj          Theme                   RSRC70�hNRSRC                    PackedScene            ��������                                            P      HUD    HealthbarPop    HealthbarQueen    resource_local_to_scene    resource_name    lifetime_randomness    emission_shape    emission_box_extents    particle_flag_align_y    particle_flag_rotate_y    particle_flag_disable_z 
   direction    spread 	   flatness    gravity    initial_velocity_min    initial_velocity_max    angular_velocity_min    angular_velocity_max    angular_velocity_curve    orbit_velocity_min    orbit_velocity_max    orbit_velocity_curve    linear_accel_min    linear_accel_max    linear_accel_curve    radial_accel_min    radial_accel_max    radial_accel_curve    tangential_accel_min    tangential_accel_max    tangential_accel_curve    damping_min    damping_max    damping_curve 
   angle_min 
   angle_max    angle_curve 
   scale_min 
   scale_max    scale_curve    color    color_ramp    color_initial_ramp    hue_variation_min    hue_variation_max    hue_variation_curve    turbulence_enabled    turbulence_noise_strength    turbulence_noise_scale    turbulence_noise_speed    turbulence_noise_speed_random    turbulence_influence_min    turbulence_influence_max $   turbulence_initial_displacement_min $   turbulence_initial_displacement_max    turbulence_influence_over_life    anim_speed_min    anim_speed_max    anim_speed_curve    anim_offset_min    anim_offset_max    anim_offset_curve    sub_emitter_mode    sub_emitter_keep_velocity    attractor_interaction_enabled    collision_mode    collision_use_scale    script    interpolation_mode    interpolation_color_space    offsets    colors 	   gradient    width    use_hdr    bake_interval    _data    point_count 	   _bundled       Script    res://main.gd ��������   Script    res://AntFollow.gd ��������   PackedScene    res://ant_graphic.tscn n����&   Script    res://AntQueen.gd ��������   Script    res://Food.gd ��������   PackedScene    res://healthbar.tscn �U���i+'   Script    res://PopLabel.gd ��������   Script    res://FoodLabel.gd ��������   Theme    res://main.tres ����}��g   Script    res://ForageLabel.gd ��������   Script    res://DistanceLabel.gd ��������   Script    res://NewsLabel.gd ��������   &   local://ParticleProcessMaterial_ixu0n 9
         local://Gradient_b5uo2 !          local://GradientTexture1D_bl22h f      &   local://ParticleProcessMaterial_w0gou �      &   local://ParticleProcessMaterial_ti7en X         local://Curve2D_fis7b 8         local://PackedScene_j32af �         ParticleProcessMaterial                      C  �?  �?
                     �?                          uD            �C        �C                              )      ���>��?  �?  �?/         D      	   Gradient    H   $        �?  �?  �?���>  �?  �?  �?    D         GradientTexture1D    I            D         ParticleProcessMaterial                     �C  �B  �?
                  A                          �C        �C                              *            D         ParticleProcessMaterial                     �?  �B  �?
                  A                          HC        HC                              &         @'        �@)      ��X>��?���=  �?D         Curve2D    M               points %   	                     �B  C                  �B  &C                  �  (CN         D         PackedScene    O      	         names "   b      Main    script    Node2D    Terrain    Background    offset_right    offset_bottom    size_flags_horizontal    size_flags_vertical    color 
   ColorRect    Rain    unique_name_in_owner 	   position 	   emitting    amount    process_material 	   lifetime    draw_order    trail_lifetime    trail_sections    trail_section_subdivisions    GPUParticles2D    Wind    Leaves    Ground    offset_top    Anthill    scale    polygon 
   Polygon2D 
   AntFollow    curve    ANT    Path2D    Ants    Node 	   AntQueen    Food    HUD    z_index    custom_minimum_size    layout_mode    anchors_preset    Control    HealthbarPop    RichTextLabel    text    ProgressBar    Value    HealthbarQueen 	   PopLabel    offset_left $   theme_override_font_sizes/font_size    Label 
   FoodLabel 	   ButtonOK    Button    SendDialog    ButtonPlus    ButtonMinus    DialogLabel    ForageLabel    theme    DistanceLabel    visible    WeatherLabel    NewsBG 
   NewsLabel    horizontal_alignment 
   NewsTimer 
   wait_time 
   autostart    Timer    NewNewsTimer    NewsFG    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    CurrentScoreLabel    HiScoreLabel 
   TickTimer    WeatherTimer 
   BabyTimer    _on_ant_queen_gameover 	   gameover    _on_button_ok_button_down    button_down    _on_button_plus_button_down    _on_button_minus_button_down    _on_news_timer_timeout    timeout    _on_new_news_timer_timeout    do_tick    _on_tick_timer_timeout    _on_weather_timer_timeout    _on_baby_timer_timeout    	   variants    Z                  HC         ���=���=��,>  �?      
     �B              �             )   ffffff�?       )   �������?            
     �B  �B               
     ��  �B              &C   ��`>��0>��@=  �?
     �B  �A
      @   @   �Ga>�k2>?F=  �?%        �  �B  P�  XB      XB  �A  �B                                                            Population Health      PA     TB      Queen Health      �@     �A     hB     HB            Population Size: 6 ants               �B     �B     �B      Stored Food: 3000mg                C     $B     6C     |B      OK       B     �A     <B      +      �?     �A      -      LB     4B     =C     �B      Send 6 to forage?                	        �B      
        �B     �B     MC                 �?     NC      Nest eating well!               �?     �@     eC     �?          �?            AntNews      @@     .C     ?C      Score: 0 hrs      @�     EC      Record: 0 hrs )   �������?      A      node_count    &         nodes     r  ��������       ����                            ����               
      ����                           	                       ����
                                    	      
                                      ����                                                  ����                                      
      ����                     	                       ����               	                       "      ����                      !                  $   #   ����             	       $   %   ����                           $   &   ����                           ,   '   ����   (      )      *      +   
                          ���-                      �������.  ����   /                 ���2                         !          �������.  ����   /   "              6   3   ����	         *   
   4   #      $      %      &   5   '   /   (      )              6   7   ����   *   
   4   #      *      +      ,   5   '   /   -      .              9   8   ����         *   
   4   /      0      1      2   5   '   /   3              ,   :   ����         +   
      4      4              9   ;   ����   *   
   4   5      0      6      2   5   '   /   7              9   <   ����   *   
   4   8      0      9      2   5   '   /   :              6   =   ����         *   
   4   ;      <      =      >   5   '   /   ?              6   >   ����         *   
   4   #      <      <      >   ?   @      A              6   @   ����	         A      *   
   4   #      %      <      B   ?   @      C              6   B   ����         *   
   4   #      D      <      E   ?   @              
   C   ����   *   
      =      F         	   G              6   D   ����	         *   
   4   4      =            H   /   I   E         J              I   F   ����   G   K   H                 I   J   ����   G   L   H                 
   K   ����   *   
      =      4      M   	   N              6   D   ����   *      +   O   L   8   M   8   N      O      /   P              6   P   ����         *   
   4   Q      R      2      S   /   T              6   Q   ����         *   
   4   U      R      V      S   /   W   E                  I   R   ����   G   X   H                  I   S   ����   G   Q   H                  I   T   ����   G   Y   H                conn_count    
         conns     F   
       V   U                     X   W                     X   Y                     X   Z                    \   [                    \   ]              #       \   ^              #      \   _              $       \   `              %       \   a                    node_paths              editable_instances                                       version       D      RSRC��~m�s�2B��RSCC      � .
  1    p  S  �  (  +  �  6  �  <  �  g    �  ?  �  (�/�` %Q �"Dx�I$6�\\HKa����x�l/�#�&�gK ш4M�[�D��U�"���x���@<<�I8����Z�R�� ���x�$g���'�,#m�$���))2��a��y���ne����wN]-�Yb���E�C�I�ָ�)�{@���&6��<+�k3�eu�`Q���ƃ��J$���]n
�А%$Zs9.�� ��,i������4��؉C�v%��x�-�<����:Fw�C�B<����6d��Р,JRQVl���"Ccj�����&')�4n9�B^d�m(��M-U[Ě���JN^X~1�U7�U��i�Q���3���e�^RO�tE��#ޕ��iy�XA����UǰV?z3b��t��$�K:G�R�}���ĦY���ղw�z�U��9Vi�	X���Q��sH�2���y�(y�}�&��V��Ӽ2kU�(&q�
͊iY���kx��o���5���Ь�ui�O���-e$�34I^M�V!��C��w�����Zu�*^����9�7�Fƍ�IC���Hm�ɣ;^��Փ�u�8�H�'뎎C\���5��#�Z��i����I�v�Uɜ#I�v����v��:������W�z�������y�����0�{�����q���w����
N�'�s7os6_s�O]�kX�DV���Q�:�?�����Dx�y�ɜv����/=�!�w�`���<�a��]��[��<˱�ʕ��8?�_�x�r^�T>�R>��<�P��<�;���M��K��I��Gn�E�t"������A<�ы.� ı�����0��v����k0ױ��+c��p��s|�gӥy�c�y<Z��:��c<��p΄<ȅ|��0�B����k�,�[�
W�j,��?�����ż����3�2��-��a<��5��7��`\�;�f�M�o`L�5W`
<�%��q��Sy�RV���Q�2?�����e�d2���c,�Kc��07�/f�^��\��Z�����X�
8#�l���*��)���I��'�؉����X����؈��D��X��<���,s�0��r��K��g�X$��ݳFlKĎ�!V�b��և�ay�V��aq�ֆճ5l��agX6��a_X϶�,�
�¦�(,�c'|��Y����>�������GX)|��X���I	�� ���v����f�v6k1�ւ��tk��j�v���\s˕��%w�݊��8nnq{ۺ�~k[�p��,;�J�o�ͶY6�f�vj�V�F�i6j��>�5�N[f���ҖiǬ�]�0�>�,�m`�,�e�,�ݲZv�ͲX��*���"��[�ZY��R�)+e�(��P��
���m�Lv�*�$�d���-�HKd�!+d�v�F[���-l_����~��\�r@�����x��{\��q<~��x��s\��q8���xg�k\��q4~��x?t2n�c\��q0����݋wq..�[\�g�@��W܊��*Nŧ���PП����o�L�ϗ���$�ď��q\ĉ��A��p��y���9��p��5<�i���1��p��-���p��Q�	�s^��p6�dؐ�0	�"����?���|�k�n'�0���6ۃ����mG�`�ǣg^.z��ԋ��=�-FO�2�ݎ6��YŸ^fhֲ� =�	WwQFT�.�t:i��C�G;�a�I��(����.<�D�CLr$��f��R�*RD�iYw��H�,{�ɯ�Hլc���H��Y�7"9��2_qL��'	��Y)V���<:��}��v�'uD�L*�Q�Jc��5Z2��MFF�tgp�&.��a�ZX��{�U�O�e����#O117���$A�7.,�ؕ���Y�*�+�*�pcXR�zT=��9�:��)�9���0)X��T#+aj`d��*"�Ȩn�-�Hk��,�8�F(���\"�	&>�DX={}�}!8Rq����tgdq���k�iC�X�:�BX��t��Ԗs��V&Wf��QQ��5�N�5�f����I��檴J���,?&6�%��`'	~��Ǹ��Uo��W�ߘ���$��1]I��sji��:���%�H����H��-Ş�Z2�Ў�bl�~����Z/���b���f�+X�`hc0
��;��b��*���b��(��O���Nl���ـѨ�0�cdF&��$I�p1SU��3�̅b���	f���F4lK�!  \�}�x�"�A(?@N��^�@��;���'K�ߌ p���cm��G�GJ1x�C+Z�g�����p,hfU,ݧl�P��f\�	C�&�aN�ǒ9M�ɦ���â���l�Zߣ�{���ň��"�����U�4���(s��;D	��h���k̖bo��f���̏�n �⒙�$�%��7�:%K⽇{�ɷ��d�E�5t�!ی�Y�d�Z�����7{j��E��7[���@n搋�����m/�s�b�q�ˇ��\?Q�@ �=������K����-� �)?�
��ovc3�b
�W���?	�?;i�ub�H@I��ܶ�$�y���r�	�
�>�oP;��hQ����(�/�` =1 :J�?@K��cf���a�a�j�˝��.B>�C�Q=lTR��Hhe�*(�9��@�0�V� � � ��,�b��vev]ם��¬˲�eU�ZӒ��U�^�V��Zk��^�R�R:�����9.�[f�֤WŔ��a��*��R)gΞ;IiaUf/�@��I�'��~d�2ޤ�?)^.=&�xK��[�t$cp����?a�Nw9���z8\��K�?�C�r�;��u���9�PB���O@�i~��]�
��ߟ;���B�2�HC�<�e𳈄w�t�O���8BS�<�.��/��P��TX��Tl4���/�AE?�T*WnנrYYo(W�3*C)�l4�#@Zcoqi��/~s[ �Ms� N0�0�<��$4��e�b"��������-���2��sP� ��2�q ],�;�o�w[��Pқ��P��`S�I��.m�9�sZM�LNL�KN+�%g���9圚61�]��,�jT��Դ,˰��lfe5���d�a�aWܶ��<���s���?^�^��NTLR� ���@�v9����~�'�`�u��=�Q"&��k��t��O�_	��4�����2vډ]�N�C|���{���i����.s�'I'6'�u^t^t^-���f�7�I�cN�!���x��eo��_<H��A�_d�d��3���y��z?�����Q:���r�T�����������d�mfh�]��ca��Dۈ�!�d�2F�̆�Z{����FEa-1��X x���8�G�T�P����#�#�z�Q�(�j��U�*
k���R]*
KA Zb%Jb��{5�����.U�.U����j/�T]l#�]�R��!���+�q�"1:0�$j�ޥ�;U)����1�����D�C���8ňq� blDm�m�o_Fl���d�_�C�|w� ;�s�����n�H�k��8�Ј�HR��0�DI����(&�$"2��� ���]�+(�������"�E̋�� D�T<� ��������N@rK�v :�f��A�>�
����z�Нeh�9�g��:Q�16�w�ej\�Qw�k��i��<��f�Y5�z'&�l��,�`�N��9b���ȹ+]�@���� #��|C.��6�g]z�С|@���>�d��:�'p�!�͓�A(m:�.+&|r��ձ������U�>5P����������Hos����Ak���s���93H��8��qm罧W�]	��K�؏��r u<�U��#���ɻ(�;�Pe
ڧ���"L^���WFB��i�D(ޠ�ɷ
���C)6AƏGU����nX���dW�7����HJ|�4�w�3. ���g���O��^�C1�����S:nnU�P�$ӆ�����]ܶb7����7����go��ĠL̆&�2�,���O��P��*C1T�b��P��2���&pN��6/��S(IV$����	d4�� I�$��&�w(�3�l��o��̡�h�&�2*���2�p���7'`A�f�$M(�/�` �( �^O"�%I�  SUUEUU񗷓v?��%��%�4�6�{�@ D F w�Y�m�r��]�\�t�R�3��-n7�ؾ��<I�.����K�m��w��`�U�S��21�و	>\�l�F�5��p����^k�e;&��賀#��=��<�����9�TY��T�ΠJ����+�aJn�l?znPt�_=���uU��uUN�%�^�=�T��Na	K����Ll���>^��Yi�
��\O�#ǃ0\O�Ҝ:S�]l�غS�W��FC��a*n^I��K�,S���E�Jm�%@8w��BuF�J��%���
���!��$IJ;c�����@5)�N)332��Ph7�'�Ÿ��l")�:����s�g ��Fd��%��#kFՒytm�yz-˳EMXu4f�,�c�SҾv��x-}�nm��c,�?�B$[�&�������m��[�:�No����v;IY�?�S� �;'j�6(��ƒ��k�6��X��X�˕�:���n���|�G8n���[b�1v	��w67~��4[��åiv�Ӧ��P�U�V���#=�encr\|�����X�&V���B���H;�� ����M��<�qqW�D�����5�����ED%�6���e�Q�Ҩ���q:�����^��Ȏ��Sy�(����� �v�a��OyG>���w�O|O��^�0'�RJ#1�?��P��kώ\E��V'ݺ�"�����86�@PI���[�Bƀ��|j�9\Y�U�s]�Xi�X�|5wA�3�� L7��7��$7���m �X��:v��� :�n�n�0��d�6]Ֆ���lYo*�_]sf�pq=�ڶ�K�k��~�:'�GD$=��_#�{�;,˩F�3����q������;!����򋥠?� ="	��:r��`1��Ev����)��vuS>2�Ӭ���և����(x�7=x�D����O�<��%�+�!㿗WA�`�����x�@�<��i��Y8\8H��L��]�����6x��O��{���$�dz��X��rCU�]��/�8 X���w�.3@�!���O�.
��i��.��I����@��h��D�l+rLX��z~�������oPXi��Oq�H�]O���fツ՜4(�˷���+x�m��8} �D�S�m����|a�o�jp���B5~�E���؛�d���q��*���,,3gz��1�[d���?�i1�sI�p߾oO$ӓ�?,
/?����_"��fY��Ct�	9��X��
�(�/�` 5+ vaW&�%I�XU�����������7r��[�}d#��-�LG N K ��!�2��G�A�АH!�{Ty&u�mc�_�R����k��>L2%R�	�.� �~��V�k�.����}���^>D
!
�x��� G�khȤ��ˀ�A,k��cRI%
I�����3ɔ	q�j�x-�*O���k�`�AX��=�9&D�v��&)W�k�2�٣��A�{"e��q�qtؾC*!42Qf��o�]8�����D��ƍʳ�}����km�e�*�*j�$eeRh�H�\8���p����>P8�C"��"0!�x5�U����_;	�0)8>C�5=���V|���a��Bd�I�J�p�����H��l��x���`�)��)(I��8v�l	I=!J�h������d�}L`�Wi��+����e�vF�!���9z�%��d�f�t|Ţ%��������i*��Eny�@Dr�%
簸40���� �`eF��c}Y�=y��,U���2�Y!yG��!�q�t,|y�e\h'��W�8� 2�Gr���À|D���/e���Ɯ[p?�VH�ED�S\�h]�άt0�ϣGz�Mj侼�wʹ��i1M���k�B*���ɐ �B�a�AVO\Q!����3�i�f�5x��ѧ4��C�)�,/���Q`r��������� �$�8�;2k�sǽ�̒�g<�<��x��O��kT��<lS�4��<�5����
��e���-���y� �?��2�/�ֵ���$�Ig��v���fu�W��q�s	���8Kϕ%�����5�6!/�&6=�}Z��3�OÈ5u�5O
��l![j_��9yuqPv��uX���z�����<���$C�a}��C����<��2xmԯ<�pE�?C!I1�ry�� �vUc���in���.0�����8�_y�
���������^�2A�謱�͔|d/F��Pvu�$q�5�"�=Slʸߗ(�2p���܉���1���Sy��,�� ���n ���K�zENv�&��O���J��u(̘4���{8�+˰�в��#��|"�L@y:��~�aؙ-���7T�	���r����퐏�!IR$(Y���vr�a@��:���ufZ5���^;�snFO��\�Ă}����b�W�Ά�?�Ɇ��8�	 �%)5�T��N�[�`06�V����<�����R Y'�7h�= R�r���
�	puG���o ���M�B(��~�C��9���o�-�m�w�;�$�����B�N�qUT���!��L��W G���?/8:!%���f��;����e�Vj#�n��*8��[��}94�T�tnp:6�X�U�(�o]�(�/�` M" �YC#�%Id�������pK����[k[Id�a�!�H"S7 7 ; �w0U��.���F�x`����[ܞc�f���=z0�l�?nv�	���dۂe+�-���w���-��\*"n#�}L͂�m~�;m}�(N� n�m�s��pB�<z��
�9}+ټͷ���h傤sL���%��Noc�q��' |���\*� X1�fؾ��1./��Zx�ߚ��`j%�n��oh�ٶ�"ۘ	�s���Zֱ��NGqP��'�UR.8u�8���a�"MR��q��cI�� $1ǒ!D���`DDFRP�Jk'	�@��G��g
�J���[k�D��s����х�����lġ�/����
M�ϋ0%w��Am�����D�%��_pP�J?��$1���]m�kh�U[V�A�+�%-��Nh��1k�������~S�734�kd�����������M��x�2��k�u��er��'���Ѽ���mkO�APB;����.������u� ��
A��0����4s�[ݱ�Jk�7Ű�F5��a\�<�Ȇ	ʤ^[4�b�ȷM��K�<#����ar=R�dj*]  ��ߦ�K,���_6H_o��dNaF[�f�܃>k����\y�99��K�r��a�l| ��j��2��������9��^1�!�q�#FV��hL7I3�/���9�
j��<zsW)"C�|#�7������4q�l~��#5.8Jc"K�hw�b.Jk2q�=�-_����A":Z�O��5�� ����)����(��������^Մ���%�3P::�4ۓ)ܾYWR�/��0aqTW(�L{ٷ��_��^7[q�O�&]{�2�K�QwI�5���|�L/�6����z-L�{m�C��v���N���?{�87/�Z^VS�iR�͕y�P갏&[�EQlADM����Um�3�a]�v�.�a�H@)Ņ p� ū��z�R,}ꅹ���jq�P���c��ja�P=Z�h����""Xf
�ܠ��ea>I��/Y���H�c�w��"�,*�+�4M'�ө�G��@^\��P�䩝(g�Q�
(�/�` �% �\J#�%I����@UU5�����FJ��f�&7��m�4���)> = D 	*i�_jj�R�Vp�z��C�K5�����
N���C-�Z�.#���˶Q�������Ӛ_z�z��jh���	Pr��exxǥ}0J\h6���W�����wr�s����z�f����_8�Qh���a�:?X�t,�`i��[��-�rZa	�` �()O����ԥ&P&8ﰂʚE�5�[�q�M*���xB���'l�6��aG%q2\N�P+��+��B�d"�d���^gX�84�H������!���$�$�q��<l�@D%H�L!effDFRP��J�5=�<���.�נ��w��_R{{|��1�m:��{��y��@�q'Td����h�N=�D5a��:�ļ`��la�W~�r9���к��{��ĹA[�`��Q��T9��)խBA����nM8���g3ÐC[f����4$��)����<Q�vǥ��`�ᄊ/��{����t{*�>>d�5,��v�qh�������աM>�C�K�$ԄWG��M����γ�8F��1�@�==05�/�e�AT�J��S
+���/�40���Ħ��$DXaY�EUX��=o��CǴ'jh��B�;��]Y�����U	����#�IN�-K�3��_&�0�6+/�#i��%.��8(�ye����io��5�\";C-s.����E��V�\��[N��g�K3�m�'^>@t���'�;�����n���b�x����]���c�*N�0O%�m8GPHx+�=X�{Ũ/�܌�nxS�
�s��ִ�`�N�n�J��[�p��b�,�J��CJ��6���K[�
B���iSͦy���h�W$�Ҥ3�s�B~����("��胛t���%vjʹ�t�����T��������3��fXD�P�Hz
r��U��cV���D��8�520P�'8�ί����O���zJ�q�l��o���8����#�ߴ���`��L��f"m��N�%���Ş�)�\%�>� LJ���p�xΗ�_���d|���b��ň�!�EY0��)���Y3��V�/b,x�m�����ru�5dT�q�P.����k"0�0n��ze��w�v^fF���!�D�r���Y'v���B�;xAx���֢
3xk��
(�/�` �( v�N$�%I{kUU���*��
��>�k�-�L,l�XB6�{�C C E ��Y�ϤL&q�KX�gk����TeP1�#6|�A��]|-�~���c��LJQ�T���l N������o�u�)����rf�*�"T�{��f�x@��`8ya��5݃���6E#�X������:۾�-h�mτ��&�6�|[�č�oͶ'�,�~����t������i�n۝�>�m��G%5�c�m�e�5۾�)*��JQ��f��`���2�h���������	�]��?[�g��I%L*%��,�Q��}���hi�dB�����?��A2��$5
�a�bq���4=���������'����W�:ǅ+3[6�1��፞8��E D�mX��|S�m)2�"�zzm�FW7R/+�z:�q@���S�u%��B��G.o\����ɔ��(�WX��A���Ҵ�E7���5����j?uw���G�BFգWt+�ʕ��
,k��>�TJfD��|^�Ky�*���Ǻh�X��Fvd©�4V��H���X!�������9^Z�\Ai%�j�S����V����4����V���̐O�O�^�Gl���縠Ȇ]���|/�kls**�Y�ƕ\~���3
ھ��+�۪��]�%M6�l�eB&G� HL�0oV�x��~���nЛg;mQ�9D�|#���7μ�Lk��&�ϛ�7$;9w�wCg�4CE�F_�0��e��@�?���H؍��+޿p͞Ʋ>�e��F�s�w�f�����٢5o'��(�{�θ����KO��r��.���;�KZ�7���{�4�i���g�ѿAO)�"1��Md�đH�k������N��C�L�U�o����Y�� P��U�"��Ww��Jx�l���`�h9{(�R��7����r�e��^����G;�l�Nɿ�K� &�8���I8%d,?��^ ��	��N�����iHI;�MON/Uh3�hU� ?)SM�`Ե�o(�={�D}��>�5��[F|���o����ֈx�'iO�������įI��~4wf���䎜=���/�U뿫�og�i	3���z��G
�w���4��'���p��U ����^���Bz��>>�����[^�5�� ?6���?���lX�X�f�:.�h�H�rG�k< ���/��y�,ߑ ����I�G���т���2����
8��WW>�v_��d��x�K\Rm��G6��`�����~�%Ꮽ������᭍B��:�wf�=���DC�B7E�悵;4�C3���H]�%ĸX�^m(�/�` ) �K#�%I�XU���������v�ok�oK"7�%��M��)= @ D p���~6 ��mCR�)�"Uz��F���e�c�g�l��e|7[����O��J�DZP!J�S��Ƕ��8��T��b��l9�[�̾S�L�p�=�Kl�v۶!�0��O)����m��(��d|��P�1r���:�
ʔJ��P��tJ����Ȥ�J~{Xbv�)��o*<��J|�%4Q!���%.y"Mz�
z��fy̌*���oa[
���W��%.���6���ԉ"D�_��P��a6W�8�5��pn�?���Q�����N�1a�y�� E1�L���$I
�ql���1�ݒ;�҅_�o�r�I5�_>c1y�%�`#r�#�(��ys9�zp�n��<c��4�F�*[z�_N�X��]�����eOK����P"��y�8!��˾�?�@���0�J���H��;k=��O��^�&k7y�ʃ=�G���Ӳ����b{�a=g~��� ~p��M�RB�A�ͅ�A|M!�;)(��o���� R���K����`�@̉�g�*�T��	0�τ�G�=���u���P��$�@д���8�
�}�Ժ׌�Z8�?;��̙�$e�0�a�lJ�V=s��ʫv S.{/�3ӳ�� �^���x�6'��(�����z#���r�Xg ;O&!`&���_6g�! |�%=�d޵���QP>1P[�+7g���m��շ+���9Ol�[x��	��e�n�G�y��7`����1�k^ߝ�x�j,�됅$�h�
��}�O��l[���ߪL�:�Q"4��¾�(v�y�
x���6���g|_�_�駺�,S�o�ex�>��+	��UZ�r���#�8��`�>|A�?��q��*���<L��ܕ��d�Wn�	��;�Q(���d��Hp����v1.�L0;��J���V1LwU%����7����(��)O8	0��[WH�圀��? ks�����d��j�{��İ|��0��(��rm{��yl�	<r��#�0F�;�
��#K�!/�����{> �7k��SǏ�!G�z/i37Z��%%��in�b����`}`�`6o(Ȯ�Ƥc�z��Y�ǯA��8K��!�,�܄Ť����5d� @����3�)\셾ʍ��H|4r2���JH?���)�_�Y�%?�i3��1(RMܱ-I�&�!��;4i@f��e҄�-A��)t�G���$�O��[���s���v�k�R�'z��ϖ�y��{7WyZ��#�)��^r���p��ֹ@2���(�/�` U, �"Z'�%Id�6  LUUUU�w��R���v�[H,i�"�NJ P N >�C�
�J��*񔲎]p���~���fϿM�-�m`et����g�}�����y���CW�T)*W.]S�ZTx���P���e�� �b����KW.�XЅ| ��S�������Y�T�J�^���_*E�n_�s���R�Aa�ͷ�7�Ğ��x6�CE�b���&�T��C�}���:����n��d���lr3*J��&v����a�m�y�I��b�|ε���0�rp{�S�&��o�.S�=�,Dn�����}�c�T��J�|ES��H�c	�*�̘2cn@e�&LP�X����̘�HJJ
�� �������1F)S4��PX�1|\{G����k�|�j���������}�ս�x
;���B�,�(��|��nk\�hr�{�{k1���m)<f���p5�1Ҩ���e|���1�Ǵ��6���d%������4��X����1x�*;m=t<.�m_�^G6��V+�OQ"$�}��x!m�&k�d�~j�ő��v��$�bnB�e����v�V�r��D�N�_{E:�E�5�H�BB�9*]!��#R7��=p����������n�s�&���}Wj�2�Y���~S��9����4���R[F�{%P]��{���f����	�MR�on��@g���9$�g��}���.;�v(��-���L�x�)�MfE����l��b ��)�q�X[@�X�2��y��9��HTB�S� �������<��=	q�"墱�z�oB�W����Ro��W�m�A�9!�@(E��cX�޻��wtU"e&�K��52���	�����9|ɹ��;w�/"��-�ǩm�=�U��8a�������䢵���� nB�fe�ah0Ϟݑ��6����S���_,>Auܰ �c�(�����bj��q����M�Ss3��/����[+��U�����x?2cB^V�
~~��!{��M[x6�:��
��;�W^�A��l�l+��JLG;�،�9���<��"��0%z~T���g��y�s�q?����Z�2���+�7{�"�a���q�yF@Y|�uG��b�����z2�J��ӷ�� �򱩂����;��n[���"�Q�_)f��|��O�O𒾿oxf�H{����0�a�`T�&��w 8>4�qD�ś�B�PF�Xx��L��	0;p �	�z�q8��Ƣ���b�!V�|�lh�����ɌAE�
���K�aq:i���1�p� ujΠ�U�ñ۟�%&�lBM�v�ϹJ�d\����IZ�$�U��g{�:,�E�Oe �̥N�Xf�ަ �.�~�������R������(�/�` e) 6M"�%I�X��TUUQUU@G�i��$�M��Q#�����)@ B F 	�H*�ہ/ۖ�&�M���\����:���� #d��oSd�-K���;�q��m�P�n�����%njn66��) .�(b˄9�>�|˗mm��T�o �4��{q;�����oI�0l�������	�j�E�X�@O&�*w�؊��MM~�m�D�=[���%/j�4lH��(b�[lkْ�+|[¤���؈(�$�sK��@��l1;<�?��M��"�����/��t6�p�����p�j���-c�C�{����X�sd8���A2����T2�a�"Q)��T%���!I��R��5$ato��&z6����S�G�Nx��9'7WQ��zȂ=����ݣ�,�������W��+��ehߖ1���{�C�]n�K�i8_K>x�QwH�z|xmF�WR��zh�q�8p�>��ao���f�*0(���H��l��~\�x��5����K�>���Zx�g�<s���u�����F��i�b�C_��V�4%`p���jg�����Ik��𕠲RP��<�F�%^�7����2g(Q�j�H�	1L=q^:���la��s�hƼY������+^�+����=Y��}Թ�JS����[~�P��
U�v�8��;_L����o�w00>/���]�����c��7������aģɼe�b 0N?\���Ȏ�`��~����_`r����J����G���0��*^"�%x)�?b8f��r]q�[I��ۙ���3-��vY�ܛ{,�TD�>�k�!�=HB�p�N_��ۇ2��>��<��|͉Yb_��A�L]�ҹm�zQ7���<��>PB�n6�y�nK���LM6�1�ζ;�{�n�,� F_�}Q��#O����*fPfP `��%��ͯ�}~�J������m�Ns��]���5�lW�!#^4q�;�ѕ��w�kht��2�噢��@V����x�'�s�7�,�z�3��
�^���4�SD��� ��/�#�bQ�L+�p���dX'��<&v,��ۑj�����WJ(�5�j��+~�(��}�p�4�-���L�N����o��S�� �[���c�;C\:^�� j0��C��]o`e6�j�2)^E���4��\��<a�C��9���H��+8�	|������Eo�؏~xd��l��j4�u_�L�q7=������� ����ʈ/.�(5�?�sBm��7��#�1����/�(�3�kO��C����l1҉:���
�L��e�Փ�R���(�/�` e' ��F"�%I����������-�g#���%�I�d;�m"�N9 = ? �"��.|�pA�;`w�16�`�F����%����Rn�t��\���=������%�l;�F/�X �'K����Tؚ/��LULj0��I�}�Rn�w���p��b�5�_)��W�15_s�u�\�4�,�eԹ4^�	q��.�H)k.��tF�0�.�ɚ�x��o�t��=��a�;��.	^��4^�t��ð�����e�a¨!�G[a&5,�"Lj���z���Sʿ9�R契�N��q��)H��9q�"Q����%GB��̌�IAJJ�6��L#3����$ ��!k���N�YW
W&.1�d��3Z����w�u�;�����/Y+"��N 0�G��$�È�y�Q�[$��?��X�r�]p���8�1N9wԳ�w�]�]��c8���$�z6�;�}3Z�n�#�n�?LÂe)-��ϊ�sS�p���O4�)��Y����`gf!#�*$�T
�GG�`|Il��o<�<�-,m	H�j��UY��D�kX�u�!�Hm�����~�;j�u�H뀽�Op_����ׅ�cH�Rl����kG��s��<>N	�|	�����$v�)�����|LZ�"�b��S�7G�ļ
ux��>����[֛�㈟Iڷ���n�h��1Y&ge���ӡ���"X,8\�;���*�m >�h����Yr�Ѧ웘W�(:k"B��Io��WO�+���:ԉ%�x҅��o�|;��p�3�ȱ'Uo�:H�bR{�[�G�(a�1�mUH����=,��:�SR��T���wW�Rr.3��k�J����
�H�##���Y8��a�7eS�}YT�R�GW��k��Ȧ?�R8�H62$k�>JU��&×d��<�͐J&���]�$��Z>��{4n�����D9C/�|�_�Nx�A��j0ݼA����x���>��O��d=�i!<Ц�����]��o��Wx)���}�d1�2��m�J
N)?����.������$s�-O'�o��ܫ�V����A��͌�1����hZ�����D��Ǵ3���h��y�zo�'C-��G��P�w�/}6_΀$zv,�UX*�Ұ��,��8�(#��n�n�ZW��{-�oo]9�X����y�Xg��GD#�|`M�,�'��&|�cgnځ�*�~oH�ML/�vh�?��*�_=�2�2���ԇ"��<l�MBB9u�ɰU'�(�/�` �) ��L#�%I� ���� UU1���OkmI�� �͒���2@ ? E �=�:s���
7o����T���
cj���B��H`�������-��~�?ac�%�6��7�����7LU=�����p�͙�����8�;��\�K��	�$�Ƙz�����{�v&$��n��w��?��;�m�>p��UFOB��Ρ#�b�O%�oQ��rW���fx�K4��M�:܄{k 'syyH�ョ��x*OH��7��c���ewUg����؛��38�rGM�7�pn�ShK{�Į��y��s�G�r0/�������a2IR�3�a�"9M� u1�j�fDDD�$%e��6�B:���}ոj�$�+ߎnA|W) 0f�}�Zn���4��X6Z�>��^�����X�)������ϛYjK�$R�Uz>7o&)��/�y��d�O&M������wq�#�oV�`��1fLVS3���]�[uD�ZP����]��;��7x���L�\�B��H�@b#<���#��+
Ezi�R��/o���h��!���s������5oO1�<o/���w�%��W@3�ze�F��F�S}r\$�<$(z;�7yT�5��'��(��?��Gus��$ xQ���������}��F�ϻUbB\�x�� �,��?�X����BM�h���GҰ�_�Z���1���G����ڬ�������E��ziS��{h�eÔl�u5�V�hW��a~0v�>`�k]7XrLt�5R�&ۮnY<�$	,C
+��#յ�g���%߮i-��'җS����*T�N�#�Z��� ��]��e�iۋ�k�H��ul�F<��8-�ԉ��j�@X'P�	�NT4z<�|X�/������t�q/�j���z���ǣ��a��iAsd����\5d�Q��O|��v=Js����7�����{�)��-{�Yo�[v��ɤn���H.dJ�(��z���-G�-�J���W��`���%ҖACV԰H2�����k7��k�ǋ/�:���X��0�v�ЩH�R�[ @{N���Π�0��;S��e����IM*
�_��ۈA�Oe*�=Ұy��b�䏀�7ɋݏi1[�m�.���*V5ٖה����)�Z���Ms�����5���������Cr4����Sz����b���p�8�,���E)����j&O��?�$?�W����2G�S�l��j/3Py�/Ǔ���mc��~��`=�ܹ^��t�J����0����i�_Ѭh�e��z��B1��q�gw�����U�%�(�/�` �& �M$�%I�5��TUUQUUG��.�o�-��,l��dIv
B C A  �>�`�MT���*q$]:��ҝ-��k�l�m߶����W�-�41)�I�!L�4)�b��\������.�_?f9^�D/��v�y��lQ�B�;����G�M�e�l�󕚇��M��"5��l�� ���aj�ax=äg�K�_���L�cH��_B0��������͆5/��;��	�]n^�(��?i�a�oe	���I�	�nW&�U�vGL��aR3�HxA%�8~``�:䛘*>��0��c��-�ʨ!��$�L��#����d1HSFddFDDD



�L-Kp�Or�L�n?�N���� ��m$�~*���c0�sF׏����k��)���p:���@��{t�n����+W��_�JV	A55_�����U�_q�vj�4Y���
A�\?�d[�ܤ
�~��Ng�x��_�ʎ���wP�]PN&c1w����]�:���1�	ģ'���r������/6��Ȩ�V��4�q)�z��>��c�u���]_��o���8�R��<��/�����*����{SZ,ݴ��A�v�%���@e}�֦a�4ʅl։���
\������AX]�s?/c=���	�7��uѫ��7j�%pW�o���_y�׻�g%084����@���R��_4�;-|��c7k���!�/�fl"3Z�v�n6��@�nu�B��}��~���BF�2�*�|`�̨��B}B�w� t���(X�8��qy��H���?���X��'ˠp�� ��|�0�X��
�-��Bt�*ہ���_n�)�&Cp�V7��,e���5���5���B��I�dCǊL���VKC߀[���6_�/����$���e�b����:��f�23�a�i9ũ^<��BA�e�e:-��4���X��>��1Ʃ�F�z#�bΟ��� PQ�{זm����=�Q�߁�<�g~��(�t\h��{���������(z�y�5��ä'*3g��s��Fd��O��g*�Zu?���p�]�nL����0H"�vn�RcӾ$b��K�#��V:NA6�|����;�Pz�����������x��IC��*�b���X�8(�!y�t����� Dz�ͷz�n�����s���A��-3����.n\:!fOP����@q�3}�{��[����ЬA>�s��*[U(�/�` �* "Y(�%I�����������W�����������ڛ�ʹ��6!r�I M L ��wyBJ��;������Z)�̬a_{b4~��H-��:�i+�l�?�EAj%F����?U.�V��ٱg������H��T��3_WJ3��4�K�fKHSфﳷ�R�|~������84��;�gf�3�����	;���k`昊��f[_����8�݌z^�w9*:#[�x�0~%R� ����S-ň�3�vf��̜"50
n3��H%"����^*��{�.wۿ������'��ˏT�`�F^�5:�w!k��)����xM�C�Ca�{V�3�K>0�9zIϭL�� 8���16�M���a!Jzj� -S��IRPP(�3\��K?�"^�<,�.J�ѓ`]���OQi�su��׆��O�(�w:Q��4S�;#աz�o��)6A(ut�|L�f���P�pG�$@�}���FZR�	9��d�}�N��/6�P|�/�8l���
�dF|Ɩ���=H�k�}�y̱�r�,8��I��n��+�l�ෟ���M؎�W�����P�ᠩ�.�	�u��D�����vM�K�[�w���|�s��O�:F�O;��
�����<� ��9��CE�i�c�_��b�B"�߷�x�[-���޴�$,��<MF�m��ZZ��>��k���O�h)	���@s(�ѿ�����F_W�����.>Iִ;���r��y��u8�.�����Y��b!B�76�!/�0�¢��ݲP���3�4���F(Pݰ��m���������3i�T(������&��nCd���K�I�-�����)�pa�u7�n="�3[�ԝM�xW��E�|��Ȩ�r�&XY��"6Q4<��1�c����4�^7i�7��
��A����徲��s��*���C�A�eϯ�f��a�_���:�'�w0k~3?���6�7��YYy���׾��m'T�K��C�;����͓�����H�k�Fm���I���rv���;	l�J�נ�h��k���ggwM���~�v��/E�q	Q�=)Mӧ��V +:Ie�p�hYM���A�rǪ����!H�A$���^<af�:?�1߂���>���1v�[�sS?�,6�jL�w&
֋��m����1&�|��	w}p�O���#�g-$QK�?�>����
~�����}�� �q�0ҽY��F�׾�(]Ht�u�/v��Q��fV|�tV魫�A����t�Y��F���G��0�ʪ@����,m:DG3!}״�_^�׎H�/�fR/��ϼ�c��<�w�{�/���(�5Le�$�5E�8�SL���(�/�` ( &_S'�%I�����������_�߶߶d��'ZIdka��6B�$2H H G ��Tx�O,1�kщTt��j�Ts�����t�8���D���7���Op��7�禹y��↫�o\/�m���D%A���<!�rs��:@ �<O�9EUP?��^�~�	W�G�
^��3<�w�{:�
�x�N��sq=a��u�;A�񧄊�O�Jr�j����7�����!��NƝ;P�6���=xP� :��t��Kp�t�r����N�|�Qx*Ϟ1L�����}��Q=*.π�P$T\޽@�_f�u�L��^�`���^����fp-Wf�CE��٨Q.�I���fa�1�ap��%1�����$I�����ao{�u�\z�!r�/�_� E��V�i�^pB��g�qLD��o����Wc��ϩ��o �v`|�H#��훦�6��n�;ql�n�u��3J�	�gffB��C��x�!F�VZ�#�9���{��a�b�Z#ε��G�!�>�)�u�y܂=�N�.�~d�-$��.J�{a6p�C�5k������J���/���+Ns�B�pF�$���e��i�Q��M���g��^��\ۯ`N&�ol�$靁m�]�>�R�$����>GWi�F�s�p��yZN~���QR9��˺0��-A��V�.��$�)t<?�?�q�AFz1r,�P���7�BR����"��f��I�k��U�딇JVf��H)$������AIQ�\��KRƊ�-R�4X4���qXÐ�&݈k��Wd7�dS-�vJeY�g�-fX06(��&y����"�����������L���` !�^�8�瑽)'�=���і��� ��g�7!�����
ɜ�JǞ!�"�#���� 覿L���y�C�F�|�d5�a����~f������q����1�\�V��(�B8Y&J���H�҆w����;��K�Ђ�M"��bZ�w�[����ώ��
�S]�kH?���f��zGk������ؼ�$��\��:/��L��e�b���x��c=��ׇ��N�� ��F^�����z��|:�z�2�>T�G���hi�iA����������@́�A-p�6N�0����щO�׼�P��	τ���{W�0@��0H���[+�H�+H[����&w���YK��!���PP�Q��Ōw"!�������&����	�X�|����ċ�u��<��9�×'`��"��%F��U2D�����(�/�` �G �ŘHP^�l�`6q@1�� �a�]r�1}@MÆgZ��9���]�֌w[ƪ��xyW��}�����;.�I��^��dے�x�⹉�&<�\�3��5;��	�{���P:���s���r�:���2��Q�wJ�R�{�<Sr�U8'ᜃ��V�+`��"�'p� k�� ��s7#݌s3� �xI�s�+�q�`66K�|��W3�枚Œ��d�$ے��[H�B��3H�R;W�V���R47��C�ͽ#Sy��b ��  �22��SF��6�$�7���,Ud�"ӊ̅�;"C9��4"w�Ր��L3䮙�f���K�WB.2��ǂ��-�_�|d�u�o�kf�d��l$s��82Ŭ�)fZ�a��d�dc��=��t�tjKt�܀|�`��ƾ���|elt�j5��NM���f�������~j��O-�Er�\�o����\�ٗ����d��ڒ��NM6�������f9�[���͎͏����S�]+dH��LN�݀����|elt�vlvd5���l�@b~�/���|9��}6;���ڏ͏�OM�h(�I��}2��Q4�C�Z34�XK�,�%�8��a^�pW�0[)�t��^�煻��΅�\���Z-,��F-���YI%=��:&ba�έ0�
c�0�
�!݄�ҼƥpN
wA�*(���5(��0�yN�h�����9ڋ	?�p�*�[	w��	�H���AFw����F�K��DG���0S�B��褢iEg�p�}@샫>���`�'y��[��"ڈ������d�''=���a|���:x���8����qC}34��yN�r���{����N�`�s�`'����P�{ns�����,V���]0��\���SBۄ�b�V�d�5�U�P�S�=
6�`��uA7	�k�qL��,	�Ip�s�:h1�;�G�il?C����S�$��@p�`�&5ً�XLvb��i��{�s`�9p��O>���k`�c`10c-����빩g1�)���%0U%pDV܊������������xFŽ++]���^�xj�}��K����&�`V�Y���FV��2�j(�s�֊b\�DqCA���-O,��HO���_����L���X��GN<��^M\�ĸ&�ib1&�1��M͛�hj�Խ%���FK,��=%vR�%�J�$J�YkI}E�%�mRg!�� q�������S�눥�8��.j��G]e�8#�1b�)歷�r�)�2�����+�U��3����
/1��{C��!�#	��=�����K_�R� ^b! �rO�NR.��wO'=���K�0�s~8̇������𮇑z���{NWq���1��a"���n��vL��t�H�stx�i��qM�4��úF����p���pƺ���n�憵pO�.��ņ�l8Ȇ��W�Q5����rW�wQ���R�}�,�t�yLW1����M��a��=(?A��P΢��_�� �2�|?��s"�dr���Ɯ!r�������~��pl\A��C��ah�$��:�k��g]o�qS���W�����G�1�wq���4������Uz<��`y|��ByL��.x��7x��5��Zw�tǴ;��c!;��:Ωc-����B�At\5�3s�$�Z[�my�5q\�����{�wn���<n���Nm,��Vl<cc������z�K�����xI�{�8L�YZ�i�H�8Z���=ջ�7Mo.Y��2S�mY�e�KW��Q�q����8h�;ǻ�7��[g�;�3�9c0,caY
�KX�a˟'�q�ka��:�-e�T�7e��q��k����k�n��n11��{��T��0���]����j��`_\��J_���^��ʋ��Xȋ�.&�b�.���gu��>V�q1�������I[|�yZ̤�4Z������KGe�-��`��`q�7]�슩�V�ڧꙪ�X������3$2
��W!�p�!� IĂ��0��/�u0����07h&�h�Ry���2,3�/R�����`ͻ�\�oG�7G,-`�E9�΅?`��wH&�c(��U�Wt�-1д�.7�_�cVv���r��C#ᩱz�|�5�=g�\�wi%ԋ�6'n��5��fH�ݫŤ�vaf�͂����L����SOw�������~T�+�⮣�i�%L��q�NQ�Q�����KVi��S���^G]�g�_ (���(�/�` �) �<�C�,�5��sf���H��%�:��(��>�E�mI+E]��N�;�
c��AT�2�M������Ƚw
� � � M&���`m颦�F���v��D��S���F+Fi�&r�I�ƣ�ֈIIe����WAѵ����"�G
bk1H|`��݌`�*�H��D9n=c���[��hֆ�^M8�V�&e="=�DA�vq3����������k��V���E+^�Ŀ�
IVm��_kkP���$P�~��}�ڽ���(��YZ�����*���J�z��߸�?\~���r���y�s������\7�ߣ6Gw���{zn����}�f�ɼ]e��n�른P(0�3[\�|j**.�a0�N��h���n'������v=�k�8��D�R�7KK%%	�4�)��N(�A�-]���p��LQ�h22�0�*�(1��	;� k K s��X�"�����//���u�J�O��ur��xU�W�}p\ڕ���눫�K��c��3��c�X,6�mb�X#6���&k¢!ǐR�	���m�0���Hb�0"���G�#V��=�b��0��:��D�V/#]N�߾��<�;���)�C��m��;������0l���n[.��P���@�3��P���o2/=S8��N��Q*Pu��Pc�3��u��C��*Q��Sԗ��Q���}�UC��T}�u�Z�Mk�5�*\��p�u��1���TbPbHbN+�������M��^����tt������;vh��2V��b�����L,+�Ⱘ��-2	Ƀ�A� a�)�f�2v9��x�8���R�]�?u�dO2�Z����1I
�J�aH1�v �VD)B�##P$��AZ4�ɇ�t>��Fa�]�x�T�W��tju����Ц�C�|#���
ĥ�,�����~d�OP�"�9�,7쑦�hlF��~ڎ�j����س(���4�T=a�,B!�8e� SZ��a���\�}��J�,�]� ��F[s	ĕ*
�^*h��=h�����o�+��.��Ԟ+��W׎���z���?vI��S��c����� �:$��~�Er�ٓYh�����<�ǄHEb�x��*���X�c\���O�4��&�7�s�0�e1md{6�|���~5r���.Ƶ����C��������uQ:�^�;*��&���<��8���4:����8y42S�̱w�Rx1>��������>��\X���w��z�}��|h��Ĩ8(����g+��/��h[&S�M�p�dL��ͼ�n��o3L�=8=@o��e���>V�s�g���Ϗ.l��(�/�`� �@�70�Jk���qv5h�����H� /lL�'���'NA�@|\���Nv���|4��L� � � {ݵ��N1�Ol��x�"1�?��sx��:����+La��'����G���!������f���Vp�|`���Z���R����Je�d�@��c�X<��;���^���b��@k�V���ųK�f�T!���e��~U�
C��?�ؗ���n��w��e�3��� �Gh�� }@1��Q�L�/��� ��vV�Md��[�"�#ꞿ�o����8[U�,���/m�q۱y�W�c�N{o;���nDk��wۉv����
�d=���6�s�y�w���ծ����;>g:�9Ά��ͅ���l^s�Ռf3���c3�k��Pv��L~�|��>.��{���8�8���6��4���c����,^1�_��ld�?V6T�T)�9Kjᄣ�iEaҢS�)��*�����u��I�$����҈�BN!�͎[G�=:8V����Z��AՠPP#�
��@C�����~2�1�;]L��]t�A��E����%s��+�ݳ��4t�S�(�މw*ZB��=��e��S�T���
X��^m��[O�w�༟ն�V��VתZ�H5��沗�\yʀ�M�'KY�Q_b7��T���/�K�=�X��W]��p���Mlj��eڝ��ی���7���E�}���������b�1Ø�Ii�\J�I��yi�t/�K�R')�0���I�9�WJ-�)}P��Q[F	�z��&ZS�	���Ll�iNj6�U�%-9��d������1��>t�֡`(	��
�dc�3j����"�����x��»抹Zn�{w���I��;��LN�;  ��ٴ-$�F��e�J/t�#��3�k�g�`@�mPK*J�+��l�*�`����Z�G'ۄ�oK��̚�Z��VW�2�b�!&�}����͐��b�lb5l��\"�e��k���RSCCHgf�v[remap]

importer="font_data_dynamic"
type="FontFile"
uid="uid://bomeeytg265xw"
path="res://.godot/imported/Minecraftia-Regular.ttf-0fa89177c20e22423e9c17d6458d6166.fontdata"
 extends Label

var value := 0
var foragers := 0

func _physics_process(delta):
	text = "Population Size: %s Ants (%s idle, %s out)" % [value, value-foragers, foragers]
��D�@�extends Node

var active := false

enum {weight, alive}

var type = ""
var my_weight = 0
var my_alive = false

var food_types = {
	"Caterpillar": {
		weight: 300,
		alive: true,},
	"Slug": {
		weight: 1000,
		alive: true,},
	"Leaf": {
		weight: 10,
		alive: false,},
	}


func initialize():
	
	var variability = 0.4
	
	var mytype = randi_range(0,6)
	mytype = min(mytype,food_types.size()-1)
	
	type = food_types.keys()[mytype]
	my_weight = food_types[type][weight]
	my_weight *= randf_range(1-variability,1+variability)
	
	my_alive = food_types[type][alive]
	if randi_range(1,5) == 2:
		my_alive = false


func set_null(): type = ""

func get_null(): return type == ""
�Zextends Label

func _physics_process(delta):
	text = "Stored Food: %smg" % round(get_node("/root/Main").stored_food)
$HIn��۸[Rextends Label

var default_news = ["Queen is lovely.", "Ants are hungry."]
var news = default_news

func _on_news_timer_timeout():
	text = get_new_text()


func _ready():
	NewsHandler.connect("news", add_news)



func get_new_text():
	var news_num = randi_range(0, news.size()-1)
	if news in default_news and news.size() > 2:
		news_num = randi_range(2, news.size()-1)
	var new_text = news[news_num]
	if new_text == text: return get_new_text()
	else: return new_text


func _on_new_news_timer_timeout():
	news = default_news


func add_news(s: String):
	news.append(s)
���_�extends Node

signal news(s: String)
func broadcast(s: String):
	news.emit(s)
<oextends Path2D

@export var ANT : PackedScene

func create_ants(out: bool, many: int):
	for i in many:
		var myant = ANT.instantiate()
		myant.dir = out
		add_child(myant)
		await get_tree().create_timer(0.2).timeout
		
#&�9RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://ant_graphic.gd ��������      local://PackedScene_ht2jp          PackedScene          	         names "         AntGraphic    loop    script    PathFollow2D 
   ColorRect    offset_right    offset_bottom    color    	   variants                              A     �@                 �?      node_count             nodes        ��������       ����                                  ����                               conn_count              conns               node_paths              editable_instances              version             RSRC� ��5�oF�5extends PathFollow2D

var dir = false

func _ready():
	if not dir:
		progress_ratio = 0.99
	else: progress_ratio = 0.01

func _physics_process(delta):
	
	$ColorRect.position = Vector2(randf_range(-1,1),randf_range(-1,1))
	if dir:
		progress_ratio += 0.01
	else:
		progress_ratio -= 0.01
	if progress_ratio <= 0 or progress_ratio >= 1:
		queue_free()
1extends Label

var value = 0

func _physics_process(delta):
	text = "Distance from nest: %scm" % value
�ի I��:�extends Node

var record = 0
var score = 0


func update_score():
	score += 1
	if record < score:
		record = score
��,и��"�g���extends Label

var value = ""

func
Rg/b�$V��@_�[remap]

path="res://.godot/exported/133200997/export-b2ba060bfcfa8c6297b3f1ea3316703f-Ant.scn"
[remap]

path="res://.godot/exported/133200997/export-a6f81c412b20438573249a6edd862784-AntQueen.scn"
��$5�I>'��[remap]

path="res://.godot/exported/133200997/export-c5faa904c52fa0da12dd478d31fc19cb-healthbar.scn"
���uL� �l�[remap]

path="res://.godot/exported/133200997/export-234ad4d8d43f2f55834435b9887da50b-main.res"
7��p��3F����[remap]

path="res://.godot/exported/133200997/export-3070c538c03ee49b7677ff960a3f5195-main.scn"
��� sQL�G�B��[remap]

path="res://.godot/exported/133200997/export-ef07071e4e345ee172aa3410c860e2fa-ant_graphic.scn"
X��!9o1�list=Array[Dictionary]([{
"base": &"Node",
"class": &"Ant",
"icon": "",
"language": &"GDScript",
"path": "res://Ant.gd"
}, {
"base": &"Ant",
"class": &"AntQueen",
"icon": "",
"language": &"GDScript",
"path": "res://AntQueen.gd"
}])
'�3���<svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><rect x="2" y="2" width="124" height="124" rx="14" fill="#363d52" stroke="#212532" stroke-width="4"/><g transform="scale(.101) translate(122 122)"><g fill="#fff"><path d="M105 673v33q407 354 814 0v-33z"/><path fill="#478cbf" d="m105 673 152 14q12 1 15 14l4 67 132 10 8-61q2-11 15-15h162q13 4 15 15l8 61 132-10 4-67q3-13 15-14l152-14V427q30-39 56-81-35-59-83-108-43 20-82 47-40-37-88-64 7-51 8-102-59-28-123-42-26 43-46 89-49-7-98 0-20-46-46-89-64 14-123 42 1 51 8 102-48 27-88 64-39-27-82-47-48 49-83 108 26 42 56 81zm0 33v39c0 276 813 276 813 0v-39l-134 12-5 69q-2 10-14 13l-162 11q-12 0-16-11l-10-65H447l-10 65q-4 11-16 11l-162-11q-12-3-14-13l-5-69z"/><path d="M483 600c3 34 55 34 58 0v-86c-3-34-55-34-58 0z"/><circle cx="725" cy="526" r="90"/><circle cx="299" cy="526" r="90"/></g><g fill="#414042"><circle cx="307" cy="532" r="60"/><circle cx="717" cy="532" r="60"/></g></g></svg>
4�I��Ut�>   @�H��3    res://Ant.tscnTMࡵ-[q   res://AntQueen.tscn�U���i+'   res://healthbar.tscn�m(!�   res://icon.svg����}��g   res://main.tresa�s�{�\   res://main.tscnD�DZ9/   res://Minecraftia-Regular.ttfn����&   res://ant_graphic.tscnl��b*#��ECFG      application/config/name         Galway-game-jam-23     application/run/main_scene         res://main.tscn    application/config/features   "         4.1    Mobile     application/config/icon         res://icon.svg     autoload/NewsHandler          *res://NewsHandler.gd      autoload/Score         *res://Score.gd "   display/window/size/viewport_width      �   #   display/window/size/viewport_height      �   )   display/window/size/window_width_override         *   display/window/size/window_height_override            display/window/stretch/mode         viewport   display/window/dpi/allow_hidpi             gui/theme/custom         res://main.tres    gui/theme/custom_font(         res://Minecraftia-Regular.ttf   #   gui/theme/default_font_antialiasing          #   rendering/renderer/rendering_method         mobile  ��>�F�4