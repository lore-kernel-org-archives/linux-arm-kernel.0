From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Thu, 2 Feb 2012 09:34:53 +0000
Subject: [PATCH] arm/dts: OMAP3: Add omap3evm and am335xevm support
In-Reply-To: <20120202045629.GJ15343@ponder.secretlab.ca>
References: <1328077620-22411-1-git-send-email-hvaibhav@ti.com>
 <20120202045629.GJ15343@ponder.secretlab.ca>
Message-ID: <79CD15C6BA57404B839C016229A409A8317BCD98@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 02, 2012 at 10:26:29, Grant Likely wrote:
> On Wed, Feb 01, 2012 at 11:57:00AM +0530, Vaibhav Hiremath wrote:
> > TI's OMAP3EVM and AM335xEVM are software development boards
> > available for OMAP35x(AM/DM37x) and AM335x devices respectively;
> > and these devices are considered under omap3 family.
> > 
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > Cc: Benoit Cousson <b-cousson@ti.com>
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > Cc: Tony Lindgren <tony@atomide.com>
> 
> Applied, thanks.
> 

Benoit and/or Grant,

Can you also pull-in/merge all other patches which I had submitted recently?

arm/dts: omap3-evm: Add i2c and twl4030 support
arm/dts: Add support for TI AM3517/05 EVM board
arm:omap2:board-generic: Add DT support for AM33xx devices
arm/dts: Add support for TI AM335x EVM board

Thanks,
Vaibhav
> g.
> 
> > ---
> >  .../devicetree/bindings/arm/omap/omap.txt          |    6 ++++++
> >  1 files changed, 6 insertions(+), 0 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
> > index dbdab40..ce78498 100644
> > --- a/Documentation/devicetree/bindings/arm/omap/omap.txt
> > +++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
> > @@ -41,3 +41,9 @@ Boards:
> > 
> >  - OMAP4 PandaBoard : Low cost community board
> >    compatible = "ti,omap4-panda", "ti,omap4430"
> > +
> > +- OMAP3 EVM : Software Developement Board for OMAP35x, AM/DM37x
> > +  compatible = "ti,omap3-evm", "ti,omap3"
> > +
> > +- AM335X EVM : Software Developement Board for AM335x
> > +  compatible = "ti,am335x-evm", "ti,am33xx", "ti,omap3"
> > --
> > 1.7.0.4
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
