From: marex@denx.de (Marek Vasut)
Date: Tue, 10 Jul 2012 17:51:12 +0200
Subject: [PATCH v2 3/7] ARM: mxs: convert m28evk board to device tree
In-Reply-To: <20120710154509.GC11813@S2101-09.ap.freescale.net>
References: <1341898587-8462-1-git-send-email-shawn.guo@linaro.org>
 <201207101737.15379.marex@denx.de>
 <20120710154509.GC11813@S2101-09.ap.freescale.net>
Message-ID: <201207101751.12903.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On Tue, Jul 10, 2012 at 05:37:15PM +0200, Marek Vasut wrote:
> > > diff --git a/arch/arm/boot/dts/m28evk.dts
> > > b/arch/arm/boot/dts/m28evk.dts
> > 
> > Just a suggestion -- why not name all the imx28-based boards' DTS files
> > "imx28- <board>.dts" ? In this case imx28-m28evk.dts , it'd make it
> > obvious where this board fits.
> 
> Because the name scheme is simply <boardname>.dts rather than
> imx28-<boardname>.dts.  Also the name of imx28-m28evk and imx28-tx28
> look a little redundant on "28".

But at least it's quite consistent and it's easy to locate your board since you 
usually know the cpu type. If you shove in just <boardname>.dts, it'll soon 
become horrible mess.

Best regards,
Marek Vasut
