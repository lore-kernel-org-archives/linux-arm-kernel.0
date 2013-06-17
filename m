From: joelagnel@ti.com (Fernandes, Joel A)
Date: Mon, 17 Jun 2013 16:25:31 +0000
Subject: [PATCH v10 5/8] dmaengine: edma: Add TI EDMA device tree binding
In-Reply-To: <201306171819.57900.arnd@arndb.de>
References: <1371263570-9323-1-git-send-email-joelagnel@ti.com>
 <3940138.jZFEtfGGLz@wuerfel>
 <083BC63EECB6FD41B8E81CF7FD87CC0F2E4E9395@DLEE08.ent.ti.com>
 <201306171819.57900.arnd@arndb.de>
Message-ID: <083BC63EECB6FD41B8E81CF7FD87CC0F2E4E9479@DLEE08.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Monday, June 17, 2013 11:20 AM
> To: Fernandes, Joel A
> Cc: Tony Lindgren; Nori, Sekhar; Matt Porter; Grant Likely; Rob Herring; Vinod
> Koul; Mark Brown; Cousson, Benoit; Russell King; Rob Landley; Andrew Morton;
> Jason Kridner; Koen Kooi; Devicetree Discuss; Linux OMAP List; Linux ARM
> Kernel List; Linux DaVinci Kernel List; Linux Kernel Mailing List; Linux
> Documentation List; Linux MMC List; Linux SPI Devel List
> Subject: Re: [PATCH v10 5/8] dmaengine: edma: Add TI EDMA device tree
> binding
> 
> On Monday 17 June 2013, Fernandes, Joel A wrote:
> > [Joel] Thanks for the suggestion, I updated it and it looks like this now:
> >
> > Required properties:
> > - compatible : "ti,edma3"
> > - ti,hwmods: Name of the hwmods associated to the EDMA
> > - ti,edma-regions: Number of regions
> > - ti,edma-slots: Number of slots
> > - #dma-cells: Should be set to <1>
> >               Clients should use a single number per DMA channel request.
> 
> That still does not say what that number refers to.
> Is it a channel number, or a request line number, or something completely
> different?
 
[Joel] 
Ah! Will fix, it's a channel number.

Thanks,
Joel
