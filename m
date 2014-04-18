From: tony@atomide.com (Tony Lindgren)
Date: Fri, 18 Apr 2014 15:27:59 -0700
Subject: [PATCH] ARM: OMAP2+: Fix config name for USB3 PHY
In-Reply-To: <20140401141135.GA4717@saruman.home>
References: <1396347274-32750-1-git-send-email-kishon@ti.com>
 <20140401141135.GA4717@saruman.home>
Message-ID: <20140418222758.GG21823@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [140401 07:17]:
> On Tue, Apr 01, 2014 at 03:44:34PM +0530, Kishon Vijay Abraham I wrote:
> > commit a70143 (drivers: phy: usb3/pipe3: Adapt pipe3 driver to Generic PHY
> > Framework) moved phy-omap-usb3 driver in drivers/usb/phy to drivers/phy and
> > also renamed the file to phy-ti-pipe3. It also renamed the config from
> > OMAP_USB3 to TI_PIPE3 in Kconfig. However the config name was not changed in
> > omap2plus_defconfig. Fixed it here.
> > 
> > Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> 
> Acked-by: Felipe Balbi <balbi@ti.com>

Applying into omap-for-v3.15/fixes thanks.

Tony
 
> > ---
> >  arch/arm/configs/omap2plus_defconfig |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> > index a966795..a4e8d01 100644
> > --- a/arch/arm/configs/omap2plus_defconfig
> > +++ b/arch/arm/configs/omap2plus_defconfig
> > @@ -226,7 +226,7 @@ CONFIG_USB_DWC3=m
> >  CONFIG_USB_TEST=y
> >  CONFIG_NOP_USB_XCEIV=y
> >  CONFIG_OMAP_USB2=y
> > -CONFIG_OMAP_USB3=y
> > +CONFIG_TI_PIPE3=y
> >  CONFIG_AM335X_PHY_USB=y
> >  CONFIG_USB_GADGET=y
> >  CONFIG_USB_GADGET_DEBUG=y
> > -- 
> > 1.7.9.5
> > 
> 
> -- 
> balbi
