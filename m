From: robertcnelson@gmail.com (Robert Nelson)
Date: Mon, 16 Nov 2015 07:23:13 -0600
Subject: [PATCH] arm, am335x: add support for the bosch shc board
In-Reply-To: <1447661758-5095-1-git-send-email-hs@denx.de>
References: <1447661758-5095-1-git-send-email-hs@denx.de>
Message-ID: <CAOCHtYjBPxQBCy6LUnj9ZWpJLXQngLZYn0z+=VMsL38QwFrDpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +
> +       cpsw_default: cpsw_default {
> +               pinctrl-single,pins = <
> +                       /* Slave 1 */
> +                       0x110 (PIN_INPUT_PULLDOWN | MUX_MODE0)
> +                       0x114 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)
> +                       0x118 (PIN_INPUT_PULLDOWN | MUX_MODE0)
> +                       0x11c (PIN_OUTPUT_PULLDOWN | MUX_MODE0)
> +                       0x120 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)
> +                       0x124 (PIN_INPUT_PULLDOWN | MUX_MODE0)
> +                       0x128 (PIN_INPUT_PULLDOWN | MUX_MODE0)
> +                       0x12c (PIN_INPUT_PULLUP | MUX_MODE0)
> +                       0x130 (PIN_INPUT_PULLDOWN | MUX_MODE0)
> +                       0x134 (PIN_INPUT_PULLDOWN | MUX_MODE0)
> +                       0x138 (PIN_INPUT_PULLDOWN | MUX_MODE0)
> +                       0x13c (PIN_INPUT_PULLDOWN | MUX_MODE0)
> +                       0x140 (PIN_INPUT_PULLDOWN | MUX_MODE0)

Please use the AM33XX_IOPAD pinmux macro:

All boards have recently be converted:

https://www.mail-archive.com/linux-omap at vger.kernel.org/msg121329.html

Regards,

-- 
Robert Nelson
https://rcn-ee.com/
