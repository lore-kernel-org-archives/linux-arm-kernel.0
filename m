From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Wed, 28 Feb 2018 10:28:07 +0100
Subject: [PATCH 1/4] dt-bindings: at24: sort manufacturers alphabetically
In-Reply-To: <20180116160618.27859-2-peda@axentia.se>
References: <20180116160618.27859-1-peda@axentia.se>
 <20180116160618.27859-2-peda@axentia.se>
Message-ID: <CAMRc=Md4mBhHXn5_vR4rB5vzvx5_27e8ArvvVocWRWHVxGKLfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-01-16 17:06 GMT+01:00 Peter Rosin <peda@axentia.se>:
> Makes them easier to find.
>
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  Documentation/devicetree/bindings/eeprom/at24.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/eeprom/at24.txt b/Documentation/devicetree/bindings/eeprom/at24.txt
> index 1812c848e369..abfae1beca2b 100644
> --- a/Documentation/devicetree/bindings/eeprom/at24.txt
> +++ b/Documentation/devicetree/bindings/eeprom/at24.txt
> @@ -38,9 +38,9 @@ Required properties:
>
>                  "catalyst",
>                  "microchip",
> +                "nxp",
>                  "ramtron",
>                  "renesas",
> -                "nxp",
>                  "st",
>
>                  Some vendors use different model names for chips which are just
> --
> 2.11.0
>

Applied to for-current. Thanks.
