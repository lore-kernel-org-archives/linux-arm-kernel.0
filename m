From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Wed, 3 Feb 2016 22:55:18 +0000
Subject: [PATCH v4 1/2] ARM: dts: imx6: Add support for Toradex Apalis
 iMX6Q/D SoM
In-Reply-To: <20160201132916.GF10671@tiger>
References: <1453675703-31594-1-git-send-email-marcel.ziswiler@toradex.com>
 <1453675703-31594-2-git-send-email-marcel.ziswiler@toradex.com>
 <20160201132916.GF10671@tiger>
Message-ID: <1454540116.11389.11.camel@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-02-01 at 21:29 +0800, Shawn Guo wrote:

[snip]

> +	/* STMPE811 touch screen controller */
> > +	stmpe811 at 41 {
> > +		compatible = "st,stmpe811";
> 
> The compatible seems to be used by kernel without a binding document.

Indeed and looking at git logs Linus himself introduced it (;-p):

commit 5a826feedc331a2d5ced2afd832199a70b3af891
Author: Linus Walleij <linus.walleij@linaro.org>
Date:???Wed Apr 23 23:35:58 2014 +0200
Subject: mfd: stmpe: Probe properly from the Device Tree
