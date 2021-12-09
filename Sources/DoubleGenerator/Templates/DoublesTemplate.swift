import Foundation

enum DoublesTemplate {
    static let template = """
{% for protocol in protocols %}
{{ protocol.accessibilityTag }}final class {{ protocol.name }}Spy: {{ protocol.name }} { {% for variable in protocol.variables %} {% if variable.isGetOnly %}
    {{ protocol.accessibilityTag }}private(set) var {{ variable.name }}Called = false
    {{ protocol.accessibilityTag }}var {{ variable.name}}Return: {{ variable.returnType}} ={% if variable.isReturnOptional %} nil {% else %} .init() {% endif %}
    {{ protocol.accessibilityTag }}var {{ variable.name }}: {{ variable.returnType }} {
        {{ variable.name }}Called = true
        return {{ variable.name}}Return
    } {% else %}
    {{ protocol.accessibilityTag }}var {{ variable.name}}: {{ variable.returnType}} ={% if variable.isReturnOptional %} nil {% else %} .init() {% endif %} {% endif %} {% endfor %} {% if protocol.isPublic %}
    public init() {} {% endif %}
    {% for function in protocol.functions %}
    {{ protocol.accessibilityTag }}private(set) var {{ function.name }}Called = false {% if function.hasParams %}
    {{ protocol.accessibilityTag }}private(set) var {{ function.name }}ParamsPassed: {{ function.paramsList }}? {% endif %} {% if function.hasClosure %}
    {{ protocol.accessibilityTag }}var {{ function.name }}Completion: {{ function.closureParam.type }}? {% endif %} {% if function.hasReturn %}
    {{ protocol.accessibilityTag }}var {{ function.name }}Return: {{ function.returnType }} ={% if function.isReturnOptional %} nil {% else %} .init() {% endif %} {% endif %}

    {{ protocol.accessibilityTag }}{{ function.fullFunction }} {
        {{ function.name }}Called = true {% if function.hasParams %}
        {{ function.name }}ParamsPassed = {{ function.paramsInternalNameList }} {% endif %} {% if function.hasClosure %}
        guard let completion = {{ function.name }}Completion else { return }
        {{ function.closureParam.usualName }}(completion) {% endif %} {% if function.hasReturn %}
        return {{ function.name }}Return {% endif %}
    }
    {% endfor %}
}
{% endfor %}
"""
}
