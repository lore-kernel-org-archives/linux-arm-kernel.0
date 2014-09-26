From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 26 Sep 2014 09:16:36 +0800
Subject: [PATCH v3 0/5] vf610: Add GPIO support
In-Reply-To: <cover.1411662961.git.stefan@agner.ch>
References: <cover.1411662961.git.stefan@agner.ch>
Message-ID: <20140926011635.GB21077@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 25, 2014 at 06:37:04PM +0200, Stefan Agner wrote:
> Stefan Agner (5):
>   pinctrl: imx: detect uninitialized pins
>   pinctrl: imx: add gpio pinmux support for vf610
>   gpio: vf610: add gpiolib/IRQ chip driver for Vybrid
>   ARM: dts: vf610: use new GPIO support
>   Documentation: dts: add bindings for Vybrid GPIO/PORT module

For patch #1, #2, #3 and #5:

Acked-by: Shawn Guo <shawn.guo@freescale.com>
