From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 21 Feb 2012 12:00:04 +0100
Subject: [PATCH 5/6 V3] atmel/nand: add DT support
In-Reply-To: <4F436AF5.5030104@atmel.com>
References: <1328524512-18159-2-git-send-email-plagnioj@jcrosoft.com>
 <1329817573-6473-1-git-send-email-plagnioj@jcrosoft.com>
 <4F436AF5.5030104@atmel.com>
Message-ID: <20120221110004.GC9371@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:59 Tue 21 Feb     , Nicolas Ferre wrote:
> On 02/21/2012 10:46 AM, Jean-Christophe PLAGNIOL-VILLARD :
> > Use a local copy of board informatin and fill with DT data.
> > 
> > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > Acked-by: Grant Likely <grant.likely@secretlab.ca>
> > Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> > Cc: devicetree-discuss at lists.ozlabs.org
> > Cc: linux-mtd at lists.infradead.org
> > ---
> > v3:
> > 
> > 	protect against !CONFIG_OF
> > 
> > Best Regards,
> > J.
> >  .../devicetree/bindings/mtd/atmel-nand.txt         |   41 +++++++
> >  arch/arm/boot/dts/at91sam9g20.dtsi                 |   17 +++
> >  arch/arm/boot/dts/at91sam9g45.dtsi                 |   17 +++
> >  arch/arm/boot/dts/at91sam9m10g45ek.dts             |   26 +++++-
> >  arch/arm/boot/dts/usb_a9g20.dts                    |   46 ++++++++-
> >  arch/arm/mach-at91/at91sam9x5.c                    |    5 -
> 
> As we will put this series on top of 9x5, we may also add the entries in
> at91sam9x5.dtsi / at91sam9x5cm.dtsi ...
will add the sam9x5 support on an other patch

Best Regards,
J.
> 
> >  arch/arm/mach-at91/board-dt.c                      |   52 ---------
> >  drivers/mtd/nand/atmel_nand.c                      |  113 ++++++++++++++++----
> >  8 files changed, 238 insertions(+), 79 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/mtd/atmel-nand.txt
> 
> Otherwise,
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> Bye,
> -- 
> Nicolas Ferre
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
