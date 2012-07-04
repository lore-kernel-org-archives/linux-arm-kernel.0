From: attila@kinali.ch (Attila Kinali)
Date: Wed, 4 Jul 2012 17:29:21 +0200
Subject: [PATCH] i.mx23: add dts node for mmc1/ssp1 Signed-off-by:
 Attila Kinali <attila@kinali.ch>
In-Reply-To: <20120704152604.GE2595@S2101-09.ap.freescale.net>
References: <1341403833-25437-1-git-send-email-attila@kinali.ch>
 <20120704135337.GC2595@S2101-09.ap.freescale.net>
 <20120704170924.76e77f02dc6fcc4579dfc169@kinali.ch>
 <20120704152604.GE2595@S2101-09.ap.freescale.net>
Message-ID: <20120704172921.80d8208bb323f8ba25198376@kinali.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 4 Jul 2012 23:26:06 +0800
Shawn Guo <shawn.guo@linaro.org> wrote:

> On Wed, Jul 04, 2012 at 05:09:24PM +0200, Attila Kinali wrote:
> > > the changes together with the <board>.dts which uses them.
> > 
> > I copied these from the mmc0 definition above. It could be these are
> > spillovers from the imx23-evk definition. Shall i move teh mmc0_pins_fixup
> > into the imx23-evk.dts file?
> > 
> The changes in the patch look good.  What I meant is we need have the
> user of mmc1_8bit_pins_a and mmc1_pins_fixup added together.  The
> "user" means a <board>.dts which refers to these pins.

Ah.. ok.. Then it will have to wait until i have the system completely
up and running. I'm still in the bring up phase and there will be
still changes in the <board>.dts (not to mention that i didn't know
about dts until yesterday and am likely to have bugs in the whole thing)

			Attila Kinali

-- 
The trouble with you, Shev, is you don't say anything until you've saved
up a whole truckload of damned heavy brick arguments and then you dump
them all out and never look at the bleeding body mangled beneath the heap
		-- Tirin, The Dispossessed, U. Le Guin
