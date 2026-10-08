# PHP Quality Config

Wspólne konfiguracje PHPCS, PHPStan i TwigCS dla projektów BeSmartAnd.Pro.

## TwigCS

Od wersji `v1.1.0` pakiet zawiera `twigcs/.twig_cs.dist.php`.
Uruchamiaj kontrolę z katalogu głównego aplikacji:

```sh
php vendor/bin/twigcs --config vendor/besmartand-pro/php-quality-config/twigcs/.twig_cs.dist.php templates/
```

Konfiguracja rozwiązuje ścieżki szablonów względem katalogu `templates/`
aplikacji korzystającej z pakietu. Dzięki temu analiza nieużywanych zmiennych
uwzględnia także użycie w szablonach nadrzędnych oraz dołączanych tagiem `include`.
Reguły i poziom ostrzeżeń pozostają domyślne.

Wspólny resolver obejmuje zwykłe ścieżki w `templates/`. Projekty z dodatkowymi
katalogami lub przestrzeniami nazw Twig mogą rozszerzyć konfigurację lokalnie.

## Sprawdzenie konfiguracji

Z katalogu aplikacji z zainstalowanym TwigCS:

```sh
sh /ścieżka/do/php-quality-config/tests/twigcs.sh
```

Test sprawdza szablon nadrzędny, `include` i rzeczywiście nieużywaną zmienną.
