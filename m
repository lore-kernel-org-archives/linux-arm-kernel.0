From: s.peter@mpl.ch (Stefan Peter)
Date: Mon, 19 Nov 2012 14:01:00 +0100
Subject: [PATCH 0/1] ARM: kirkwood: Convert the mplcec4 board to pinctrl
In-Reply-To: <20121119121833.GI10259@lunn.ch>
References: <cover.1353319919.git.s.peter@mpl.ch>
 <20121119111838.GH10259@lunn.ch> <50AA2118.7050700@mpl.ch>
 <20121119121833.GI10259@lunn.ch>
Message-ID: <50AA2D8C.90902@mpl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew

Am 19.11.2012 13:18, schrieb Andrew Lunn:
> 
> Humm..
> 
> Try enabling CONFIG_DEBUG_PINCTRL. It prints out a lot of debug as the
> driver loads.


This is what I get

kirkwood-pinctrl f1010000.pinctrl: try to register 50 pins ...
pinctrl core: registered pin 0 (PIN0) on f1010000.pinctrl
pinctrl core: registered pin 1 (PIN1) on f1010000.pinctrl
...
pinctrl core: registered pin 12 (PIN12) on f1010000.pinctrl
pinctrl core: registered pin 13 (PIN13) on f1010000.pinctrl
pinctrl core: registered pin 14 (PIN14) on f1010000.pinctrl
pinctrl core: registered pin 15 (PIN15) on f1010000.pinctrl
pinctrl core: registered pin 16 (PIN16) on f1010000.pinctrl
pinctrl core: registered pin 17 (PIN17) on f1010000.pinctrl
...
pinctrl core: add 8 pinmux maps
pinctrl core: add 2 pinmux maps
pinctrl core: add 1 pinmux maps
kirkwood-pinctrl f1010000.pinctrl: unknown pin mmp13
pinctrl core: add 6 pinmux maps
pinctrl core: failed to register map default (5): invalid type given
kirkwood-pinctrl f1010000.pinctrl: registered pinctrl driver

I tried to get behind the reason for the "unknown pin mpp13" hoping that
the subsequent errors regarding the maps are related, but it may be
faster asking for your opinion.

Regards

Stefan Peter

-- 
MPL AG, Switzerland                     http://www.mpl.ch
Tel. +41 (0)56 483 34 34          Fax: +41(0)56 493 30 20
