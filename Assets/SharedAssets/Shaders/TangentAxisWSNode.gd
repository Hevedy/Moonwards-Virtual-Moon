tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeTangentAxisWS

func _get_name():
	return "TangentAxisWS"

func _get_category():
	return "Vector"

#func _get_subcategory():
#	return ""

func _get_description():
	return "Outputs world tangents vectors"

func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count():
	return 0

#func _get_input_port_name(port: int):
#	match port:
#		0:
#			return ""

#func _get_input_port_type(port: int):
#	match port:
#		0:
#			return VisualShaderNode.PORT_TYPE_SCALAR

func _get_output_port_count():
	return 3

func _get_output_port_name(port):
	match port:
		0:
			return "x"
		1:
			return "y"
		2:
			return "z"

func _get_output_port_type(port):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_VECTOR
		2:
			return VisualShaderNode.PORT_TYPE_VECTOR

func _get_global_code(mode):
	return """
void GetWorldTangents( out vec3 _X, out vec3 _Y, out vec3 _Z ) {
	_X = vec3(1.0,0.0,0.0); 
	//normalize(
	_Y = vec3(0.0,0.0,1.0);
	_Z = vec3(0.0,1.0,0.0);
}
"""

func _get_code(input_vars, output_vars, mode, type):
	return "GetWorldTangents(%s,%s,%s);" % [output_vars[0],output_vars[1],output_vars[2]]
