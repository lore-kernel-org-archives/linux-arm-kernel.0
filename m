From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 14 Sep 2016 08:19:24 -0700
Subject: [PATCH 2/2] dt-bindings: i2c-meson: add gxbb compatible string
In-Reply-To: <1473846557-18123-3-git-send-email-jbrunet@baylibre.com> (Jerome
 Brunet's message of "Wed, 14 Sep 2016 11:49:17 +0200")
References: <1473846557-18123-1-git-send-email-jbrunet@baylibre.com>
 <1473846557-18123-3-git-send-email-jbrunet@baylibre.com>
Message-ID: <7hmvjamrur.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> From: Neil Armstrong <narmstrong@baylibre.com>
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>

> ---
>  Documentation/devicetree/bindings/i2c/i2c-meson.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-meson.txt b/Documentation/devicetree/bindings/i2c/i2c-meson.txt
> index 682f9a6f766e..386357d1aab0 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-meson.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-meson.txt
> @@ -1,7 +1,7 @@
>  Amlogic Meson I2C controller
>  
>  Required properties:
> - - compatible: must be "amlogic,meson6-i2c"
> + - compatible: must be "amlogic,meson6-i2c" or "amlogic,meson-gxbb-i2c"
>   - reg: physical address and length of the device registers
>   - interrupts: a single interrupt specifier
>   - clocks: clock for the device
