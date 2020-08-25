tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeObjectWS

func _get_name() -> String:
	return "ObjectWS"

func _get_category() -> String:
	return "Vector"

#func _get_subcategory():
#	return ""

func _get_description() -> String:
	return "Outputs world position"

func _get_return_icon_type() -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count() -> int:
	return 0

#func _get_input_port_name(port: int):
#	match port:
#		0:
#			return ""

#func _get_input_port_type(port: int):
#	match port:
#		0:
#			return VisualShaderNode.PORT_TYPE_SCALAR

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port: int) -> String:
	return "vector"

func _get_output_port_type(port: int) -> int:
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_global_code(mode: int) -> String:
	return """
vec3 GetWorldPosition( mat4 _WMatrix ) {
	return _WMatrix[3].xyz;
}
"""

func _get_code(input_vars: Array, output_vars: Array, mode: int, type: int) -> String:
	return "%s = GetWorldPosition(WORLD_MATRIX);" % [output_vars[0]]
