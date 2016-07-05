From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 05 Jul 2016 10:09:42 +0200
Subject: [PATCH 4/6] irqchip: add irqchip driver for nuc900
In-Reply-To: <577B660D.50908@iommu.org>
References: <1466851042-22239-1-git-send-email-vw@iommu.org>
 <8706947.5rzUDVsB2F@wuerfel> <577B660D.50908@iommu.org>
Message-ID: <4905263.SDvl9l5FN0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, July 5, 2016 3:47:25 PM CEST Wan Zongshun wrote:
> On 2016?06?29? 23:27, Arnd Bergmann wrote:
> > On Saturday, June 25, 2016 6:37:20 PM CEST Wan Zongshun wrote:
> >> +#define IRQ_WDT             W90X900_IRQ(1)
> >> +#define IRQ_WWDT    W90X900_IRQ(2)
> >> +#define IRQ_LVD             W90X900_IRQ(3)
> >> +#define IRQ_EXT0    W90X900_IRQ(4)
> >> +#define IRQ_EXT1    W90X900_IRQ(5)
> >> +#define IRQ_EXT2    W90X900_IRQ(6)
> >> +#define IRQ_EXT3    W90X900_IRQ(7)
> >> +#define IRQ_EXT4    W90X900_IRQ(8)
> >> +#define IRQ_EXT5    W90X900_IRQ(9)
> >> +#define IRQ_EXT6    W90X900_IRQ(10)
> >
> > I'd suggest dropping the list, the contents are now in the dts.
> 
> Do you think I should put one irqmap header file into this
> /arch/arm/boot/dts/include/dt-bindings folder, or I should removed those 
> irqnumber map anywhere, just hardcode the irqnumber in dts file?

Just hardcode it.

	Arnd
