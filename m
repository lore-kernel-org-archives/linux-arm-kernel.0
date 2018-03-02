From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Fri, 2 Mar 2018 11:17:17 +0100
Subject: [PATCH 2/4] dt-bindings: at24: add compatible for nxp,se97b
In-Reply-To: <20180116160618.27859-3-peda@axentia.se>
References: <20180116160618.27859-1-peda@axentia.se>
 <20180116160618.27859-3-peda@axentia.se>
Message-ID: <CAMRc=MfcyxsupU9-9Bv+U-U6bcNVYx44ixnmXM8r=xn6b-7sVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-01-16 17:06 GMT+01:00 Peter Rosin <peda@axentia.se>:
> The datasheet talks about the chip being an spd, but the chip is writable
> so atmel,24c02 is more appropriate as fallback.
>
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  Documentation/devicetree/bindings/eeprom/at24.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/eeprom/at24.txt b/Documentation/devicetree/bindings/eeprom/at24.txt
> index abfae1beca2b..edf9247613f6 100644
> --- a/Documentation/devicetree/bindings/eeprom/at24.txt
> +++ b/Documentation/devicetree/bindings/eeprom/at24.txt
> @@ -46,6 +46,7 @@ Required properties:
>                  Some vendors use different model names for chips which are just
>                  variants of the above. Known such exceptions are listed below:
>
> +                "nxp,se97b" - the fallback is "atmel,24c02",
>                  "renesas,r1ex24002" - the fallback is "atmel,24c02"
>
>    - reg: The I2C address of the EEPROM.
> --
> 2.11.0
>

Applied to for-next, thanks.

Bart
