From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Sat, 12 Apr 2014 02:31:09 +0300
Subject: [PATCH 07/11] ARM: dts: Enable N900 keybaord sleep leds by default
In-Reply-To: <1397173639-29587-8-git-send-email-tony@atomide.com>
References: <1397173639-29587-1-git-send-email-tony@atomide.com>
 <1397173639-29587-8-git-send-email-tony@atomide.com>
Message-ID: <20140411233109.GG15736@drone.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Apr 10, 2014 at 04:47:15PM -0700, Tony Lindgren wrote:
> +        leds {
> +                compatible = "gpio-leds";
> +                heartbeat {
> +                        label = "debug::sleep";
> +                        gpios = <&gpio6 2 GPIO_ACTIVE_HIGH>;  /* gpio162 */
> +                        linux,default-trigger = "default-on";

Just some very minor nits, spaces should be converted to TABs here
for indent, and patch title should say "keyboard" instead of "keybaord".

Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>

> +			pinctrl-names = "default";
> +			pinctrl-0 = <&debug_leds>;
> +                };
> +        };

A.
