From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 28 Mar 2017 09:17:47 +0100
Subject: [PATCH] MAINTAINERS: Add memory drivers to AT91 entry
In-Reply-To: <030be639-2114-7588-5671-b3ec4377dfa3@microchip.com>
References: <20170327152101.21977-1-alexandre.belloni@free-electrons.com>
 <030be639-2114-7588-5671-b3ec4377dfa3@microchip.com>
Message-ID: <20170328081747.v4qq6snmbaxlrxjl@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 27 Mar 2017, Nicolas Ferre wrote:

> Le 27/03/2017 ? 17:21, Alexandre Belloni a ?crit :
> > Both atmel-ebi and atmel-sdram are maintained as part of the Atmel ARM
> > SoCs.
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks.

Please add my Ack, or:
  Suggested-by: Lee Jones <lee.jones@linaro.org>

> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index c45c02bc6082..6531d239db6b 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1111,6 +1111,7 @@ F:	arch/arm/boot/dts/at91*.dtsi
> >  F:	arch/arm/boot/dts/sama*.dts
> >  F:	arch/arm/boot/dts/sama*.dtsi
> >  F:	arch/arm/include/debug/at91.S
> > +F:	drivers/memory/atmel*
> >  
> >  ARM/ATMEL AT91 Clock Support
> >  M:	Boris Brezillon <boris.brezillon@free-electrons.com>
> > 
> 
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
