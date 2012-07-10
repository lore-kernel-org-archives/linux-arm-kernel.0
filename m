From: marex@denx.de (Marek Vasut)
Date: Tue, 10 Jul 2012 17:37:15 +0200
Subject: [PATCH v2 3/7] ARM: mxs: convert m28evk board to device tree
In-Reply-To: <20120710152350.GA11813@S2101-09.ap.freescale.net>
References: <1341898587-8462-1-git-send-email-shawn.guo@linaro.org>
 <201207100920.03867.marex@denx.de>
 <20120710152350.GA11813@S2101-09.ap.freescale.net>
Message-ID: <201207101737.15379.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On Tue, Jul 10, 2012 at 09:20:03AM +0200, Marek Vasut wrote:
> > Dear Shawn Guo,
> > 
> > > From: Marek Vasut <marex@denx.de>
> > 
> > [...]
> > 
> > > +	sound {
> > > +		compatible = "fsl,imx28-evk-sgtl5000",
> > 
> > imx28-evk ? ;-)

Good on my end.

> Fixed as below.
> 
> Regards,
> Shawn

[...]

> diff --git a/arch/arm/boot/dts/m28evk.dts b/arch/arm/boot/dts/m28evk.dts

Just a suggestion -- why not name all the imx28-based boards' DTS files "imx28-
<board>.dts" ? In this case imx28-m28evk.dts , it'd make it obvious where this 
board fits.

[...]

Best regards,
Marek Vasut
