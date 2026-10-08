#!/bin/sh
set -eu

package_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
application_dir=$(pwd)
check_dir=$(mktemp -d)
trap 'rm -rf "$check_dir"' EXIT HUP INT TERM

mkdir "$check_dir/templates"

cat > "$check_dir/templates/parent.twig" <<'TWIG'
{{ inherited_value }}
{% block body %}{% endblock %}
TWIG

cat > "$check_dir/templates/partial.twig" <<'TWIG'
{{ included_value }}
TWIG

cat > "$check_dir/templates/child.twig" <<'TWIG'
{% extends 'parent.twig' %}
{% set inherited_value = 'parent' %}
{% block body %}
    {% set included_value = 'partial' %}
    {% include 'partial.twig' %}
{% endblock %}
TWIG

cd "$check_dir"
php "$application_dir/vendor/bin/twigcs" --config "$package_dir/twigcs/.twig_cs.dist.php" templates/

cat >> templates/child.twig <<'TWIG'
{% set unused_value = 'unused' %}
TWIG

if php "$application_dir/vendor/bin/twigcs" --config "$package_dir/twigcs/.twig_cs.dist.php" templates/ > output.txt; then
    echo 'Expected an unused variable warning.' >&2
    exit 1
fi

grep -q 'Unused variable "unused_value"' output.txt

if grep -Eq 'Unused variable "(inherited_value|included_value)"' output.txt; then
    cat output.txt >&2
    exit 1
fi

echo 'TwigCS inheritance, include and unused variable checks passed.'
