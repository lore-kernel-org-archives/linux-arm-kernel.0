From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 19 Dec 2017 09:16:11 +0000
Subject: [PATCH v6] atmel_flexcom: Support resuming after a chip reset
In-Reply-To: <5aff8591-f7d9-7f6d-bf3b-063014ce4bd5@microchip.com>
References: <20171212162119.32138-1-romain.izard.pro@gmail.com>
 <20171218201907.GU7022@piout.net>
 <5aff8591-f7d9-7f6d-bf3b-063014ce4bd5@microchip.com>
Message-ID: <20171219091611.7naco4ac4g2km5wj@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 Dec 2017, Nicolas Ferre wrote:

> On 18/12/2017 at 21:19, Alexandre Belloni wrote:
> > On 12/12/2017 at 17:21:19 +0100, Romain Izard wrote:
> >> The controller used by a flexcom module is configured at boot, and left
> >> alone after this. In the suspend mode called "backup with self-refresh"
> >> available on SAMA5D2, the chip will resume with most of its registers
> >> reset. In this case, we need to restore the state of the flexcom driver
> >> on resume.
> >>
> >> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
> > 
> > Seems good to me
> > 
> > Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> Thanks Romain, of course I can add the tags that I gave you already:
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Tested-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> Lee,
> It seems that you already gave your tag for the v5 of this patch. The
> wording is even better with this patch. So, can you take this patch in
> your tree?

Done. :)

-- 
Lee Jones
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
