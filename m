From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 4 Nov 2013 21:53:03 +0800
Subject: [PATCH] ARM: imx: drop support for irq priorisation
In-Reply-To: <20131104094810.GH14892@pengutronix.de>
References: <1383553022-6983-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20131104084129.GS24559@pengutronix.de>
 <20131104094810.GH14892@pengutronix.de>
Message-ID: <20131104135259.GC11031@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Mon, Nov 04, 2013 at 10:48:10AM +0100, Uwe Kleine-K?nig wrote:
> Hello Shawn,
> 
> I didn't add you to the list of recipents for this patch after
> consulting the MAINTAINERS file. Sascha now told me that it's probably
> you who takes this patch?!

Ah, yes.  I've been helping collect i.MX patches for a couple of cycles
with Sascha's nod.

> I suggest to fix MAINTAINERS accordingly.
> Maybe just merge the entries "ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
> and "ARM/FREESCALE IMX6"?

Yea, that should help me handle i.MX patches more quickly.  If you send
a patch for it, I would suggest merge MXS entry into IMX one as well,
and add "F: arch/arm/boot/dts/imx*" line.

Shawn
