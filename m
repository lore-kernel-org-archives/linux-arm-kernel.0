From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 6 Dec 2017 09:20:04 -0200
Subject: [PATCH 2/3] ARM: dts: imx6sl-evk: Rearrange the regulators node
In-Reply-To: <1512528784-29288-2-git-send-email-marcofrk@gmail.com>
References: <1512528784-29288-1-git-send-email-marcofrk@gmail.com>
 <1512528784-29288-2-git-send-email-marcofrk@gmail.com>
Message-ID: <CAOMZO5DcOeGG6KaHptMD0fO1K9RE9jHXBirUdRXG-SHd1ZFfmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marco,

You missed to pass the v2 notation for this patch in the Subject.

On Wed, Dec 6, 2017 at 12:53 AM, Marco Franchi <marcofrk@gmail.com> wrote:

> +       reg_usb_otg1_vbus: regulator-usb-otg1-vbus {
> +               compatible = "regulator-fixed";
> +               regulator-name = "usb_otg1_vbus";
> +               regulator-min-microvolt = <5000000>;
> +               regulator-max-microvolt = <5000000>;
> +               gpio = <&gpio4 0 0>;

gpio = <&gpio4 0 GPIO_ACTIVE_HIGH>;

would easier to read.

> +       reg_usb_otg2_vbus: regulator-usb-otg2-vbus {
> +               compatible = "regulator-fixed";
> +               regulator-name = "usb_otg2_vbus";
> +               regulator-min-microvolt = <5000000>;
> +               regulator-max-microvolt = <5000000>;
> +               gpio = <&gpio4 2 0>;

Ditto.

> -               };
> +       reg_lcd_3v3: regulator-lcd-3v3 {
> +               compatible = "regulator-fixed";
> +               regulator-name = "lcd-3v3";
> +               gpio = <&gpio4 3 0>;

Ditto.
