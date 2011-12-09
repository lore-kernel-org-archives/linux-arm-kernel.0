From: tony@atomide.com (Tony Lindgren)
Date: Thu, 8 Dec 2011 16:45:07 -0800
Subject: [PATCHv2] ARM: OMAP: hsmmc: Fix mux for non-OMAP pins
In-Reply-To: <1321565988-4511-3-git-send-email-weber@corscience.de>
References: <1321565988-4511-1-git-send-email-weber@corscience.de>
 <1321565988-4511-3-git-send-email-weber@corscience.de>
Message-ID: <20111209004507.GJ31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Thomas Weber <weber@corscience.de> [111117 13:05]:
> The Devkit8000 uses a TWL4030 pin for card detection.
> Thats why the error:
> _omap_mux_init_gpio: Could not set gpio192
> occurs.
> 
> This patch checks that the pin is on OMAP before
> calling omap_mux_init_gpio.

Thanks applying into omap driver branch.

Tony
