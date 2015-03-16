From: tony@atomide.com (Tony Lindgren)
Date: Mon, 16 Mar 2015 15:04:29 -0700
Subject: [PATCH v3 0/3] ARM: dts: add openpandora device support
In-Reply-To: <1425072399-23152-1-git-send-email-marek@goldelico.com>
References: <1425072399-23152-1-git-send-email-marek@goldelico.com>
Message-ID: <20150316220429.GM12397@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Marek Belisko <marek@goldelico.com> [150227 13:30]:
> changes from v2:
> - fix missing PIN_INPUT for penirq node
> - added Reviewed-by and Tested-by
> 
> changes from v1:
> - add new boards to makefile in patch 2,3 (don't add them
> in separate commit together), fix gpmc issues (reported by Tony Lindgren)
> 
> - fix various issues reported by Grazvydas Ignotas
> (drop internal pullups from pinmux as external are in place,
> fix gpio buttons active state ...)
> 
> This series of patches adds initial device tree support for the
> OpenPandora. The most important parts are working (display, keyboard,
> touch, charging, fuel gauge, musb port, sd/mmc ports, leds, buttons).
> Not yet supported are: usb host port, nubs, wifi, bluetooth, audio.
> 
> First patch add common dtsi file which is then used in 600mhz and 1ghz
> variants of openpandora which support is added in patches 2 and 3.
> 
> H. Nikolaus Schaller (3):
>   ARM: dts: omap3-pandora: add common device tree
>   ARM: dts: omap3-pandora: add OMAP3530 600 MHz version
>   ARM: dts: omap3-pandora: add DM3730 1 GHz version

Thanks everybody for doing this, applying into omap-for-v4.1/dt.

Regards,

Tony
