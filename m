From: horms@verge.net.au (Simon Horman)
Date: Mon, 25 Aug 2014 10:19:30 +0900
Subject: [PATCH] ARM: shmobile: koelsch: Remove non-existent i2c6 pinmux
In-Reply-To: <20140824182344.GB11563@localhost>
References: <1408054750-9642-1-git-send-email-horms+renesas@verge.net.au>
 <20140824182344.GB11563@localhost>
Message-ID: <20140825011930.GC31233@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 24, 2014 at 11:23:44AM -0700, Olof Johansson wrote:
> On Fri, Aug 15, 2014 at 07:19:10AM +0900, Simon Horman wrote:
> > From: Geert Uytterhoeven <geert+renesas@glider.be>
> > 
> > On r8a7791, i2c6 (aka iic3) doesn't need pinmux, but the koelsch dts
> > refers to non-existent pinmux configuration data:
> > 
> > pinmux core: sh-pfc does not support function i2c6
> > sh-pfc e6060000.pfc: invalid function i2c6 in map table
> > 
> > Remove it to fix this.
> > 
> > Fixes: commit 1d41f36a68c0f4e9b01d563ce33bab5201858b54 ("ARM: shmobile:
> >        koelsch dts: Add VDD MPU regulator for DVFS")
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> >  arch/arm/boot/dts/r8a7791-koelsch.dts | 7 -------
> >  1 file changed, 7 deletions(-)
> > 
> > Hi Olof, Arnd, Kevin,
> > 
> > please consider this as a fix for v3.17.
> 
> Applied.

Thanks!
