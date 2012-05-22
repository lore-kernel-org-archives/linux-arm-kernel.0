From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 22 May 2012 14:08:31 +0800
Subject: [PATCH v2 10/12] ARM: dts: imx6q-sabrelite: add usb devices
In-Reply-To: <20120522055901.GR6206@b20223-02.ap.freescale.net>
References: <1337592237-5090-1-git-send-email-richard.zhao@freescale.com>
 <1337592237-5090-11-git-send-email-richard.zhao@freescale.com>
 <20120522051005.GN8140@S2101-09.ap.freescale.net>
 <20120522055901.GR6206@b20223-02.ap.freescale.net>
Message-ID: <20120522060828.GP8140@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 22, 2012 at 01:59:02PM +0800, Richard Zhao wrote:
> Yes, but we don't have now. If I add dependency which don't even hit
> next tree, I experienced people refuse pick my patch.
> Of course, If you're ok to pick other patches, I can leave the code
> locally for test.

I'm fine for now.

> > > +				gpios {
> > > +					pinctrl_gpio_hog: gpiohog {
> > > +					};
> > > +				};
> > > +
> > Why the empty nodes?
> It's place holder that let use know to add gpio hog-on-boot in board dts.
> 
It's meaningless.  Please remove it.

-- 
Regards,
Shawn
