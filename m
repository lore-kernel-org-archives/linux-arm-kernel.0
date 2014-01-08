From: tony@atomide.com (Tony Lindgren)
Date: Tue, 7 Jan 2014 17:28:18 -0800
Subject: [PATCH] ARM: configs: Select USB PHY for AM335x SoC
In-Reply-To: <20131226232105.GA2456@localhost>
References: <1386861269-28949-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131226120833.GA24645@localhost>
 <20131226155555.GA3937@saruman.home>
 <20131226232105.GA2456@localhost>
Message-ID: <20140108012817.GM5074@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ezequiel Garcia <ezequiel.garcia@free-electrons.com> [131226 15:22]:
> On Thu, Dec 26, 2013 at 09:55:55AM -0600, Felipe Balbi wrote:
> > On Thu, Dec 26, 2013 at 09:08:34AM -0300, Ezequiel Garcia wrote:
> > > Felipe,
> > > 
> > > On Thu, Dec 12, 2013 at 12:14:29PM -0300, Ezequiel Garcia wrote:
> > > > Enable this option as it's required to use USB on AM335x SoC.
> > > > 
> > > > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > > > ---
> > > >  arch/arm/configs/omap2plus_defconfig | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> > > > index 12c848e..e427b95 100644
> > > > --- a/arch/arm/configs/omap2plus_defconfig
> > > > +++ b/arch/arm/configs/omap2plus_defconfig
> > > > @@ -223,6 +223,7 @@ CONFIG_USB_TEST=y
> > > >  CONFIG_NOP_USB_XCEIV=y
> > > >  CONFIG_OMAP_USB2=y
> > > >  CONFIG_OMAP_USB3=y
> > > > +CONFIG_AM335X_PHY_USB=y
> > > >  CONFIG_USB_GADGET=y
> > > >  CONFIG_USB_GADGET_DEBUG=y
> > > >  CONFIG_USB_GADGET_DEBUG_FILES=y
> > > > -- 
> > > > 1.8.1.5
> > > > 
> > > 
> > > Maybe you can take this through your tree?
> > 
> > sorry, no. This should go through Tony to avoid conflicting.
> > 
> 
> Tony?

Sorry for the delay, applying into omap-for-v3.14/fixes-not-urgent.

Regards,

Tony
