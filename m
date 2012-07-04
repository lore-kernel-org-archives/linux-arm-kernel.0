From: attila@kinali.ch (Attila Kinali)
Date: Wed, 4 Jul 2012 17:09:24 +0200
Subject: [PATCH] i.mx23: add dts node for mmc1/ssp1 Signed-off-by:
 Attila Kinali <attila@kinali.ch>
In-Reply-To: <20120704135337.GC2595@S2101-09.ap.freescale.net>
References: <1341403833-25437-1-git-send-email-attila@kinali.ch>
 <20120704135337.GC2595@S2101-09.ap.freescale.net>
Message-ID: <20120704170924.76e77f02dc6fcc4579dfc169@kinali.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 4 Jul 2012 21:53:38 +0800
Shawn Guo <shawn.guo@linaro.org> wrote:

> Suggested subject prefix "ARM: dts: imx23: ..."

Ok

> > +					fsl,pinmux-ids = <0x0002 0x0012 0x0022
> > +						0x0032 0x0042 0x0052 0x0062
> > +						0x0072 0x0142 0x0132 0x0182>;
> 
> Please take a look at the following branch to see how these should be
> formated now.
> 
> http://git.linaro.org/gitweb?p=people/shawnguo/linux-2.6.git;a=shortlog;h=refs/heads/mxs/dt-for-3.6

Ok

> > +				mmc1_pins_fixup: mmc1-pins-fixup {
> > +					fsl,pinmux-ids = <0x0132 0x0182>;
> > +					fsl,pull-up = <0>;
> > +				};
> 
> I do not want to have these pinctrl setup added along.  Please submit
> the changes together with the <board>.dts which uses them.

I copied these from the mmc0 definition above. It could be these are
spillovers from the imx23-evk definition. Shall i move teh mmc0_pins_fixup
into the imx23-evk.dts file?

			Attila Kinali

-- 
The trouble with you, Shev, is you don't say anything until you've saved
up a whole truckload of damned heavy brick arguments and then you dump
them all out and never look at the bleeding body mangled beneath the heap
		-- Tirin, The Dispossessed, U. Le Guin
