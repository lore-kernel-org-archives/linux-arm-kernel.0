From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 16 Mar 2017 10:24:17 +0800
Subject: [PATCH v6 08/14] mmc: sdhci-xenon: Add Marvell Xenon SDHC core
 functionality
In-Reply-To: <10855817-e693-e007-9499-c4e97936fadb@marvell.com>
References: <cover.ff78bebe0384f650a51e5e6f0f1dca6e7894b53b.1487091464.git-series.gregory.clement@free-electrons.com>
 <cb885ae19e7c467908cdaa1f1cc8d95a7217d663.1487091464.git-series.gregory.clement@free-electrons.com>
 <CAPDyKFpH+RGAZGoVCuCOKJ2iEa+Y=cNNcM-uKhkYaTpmogXCKA@mail.gmail.com>
 <10855817-e693-e007-9499-c4e97936fadb@marvell.com>
Message-ID: <20170316102417.0909bccc@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ziji

On Wed, 15 Mar 2017 21:58:43 +0800 Ziji Hu wrote:

> Hi Ulf,
> 
> On 2017/3/15 21:11, Ulf Hansson wrote:
> > On 14 February 2017 at 18:01, Gregory CLEMENT
> > <gregory.clement@free-electrons.com> wrote:  
> >> From: Hu Ziji <huziji@marvell.com>  
> <snip>
> >> +config MMC_SDHCI_XENON
> >> +       tristate "Marvell Xenon eMMC/SD/SDIO SDHCI driver"
> >> +       depends on MMC_SDHCI_PLTFM
> >> +       help
> >> +         This selects Marvell Xenon eMMC/SD/SDIO SDHCI.
> >> +         If you have a machine with integrated Marvell Xenon SDHC IP,  
> > 
> > /s/SDHC/SDHCI
> >   
> 
> 	Sorry. I don't get your point.
> 	Could you please give more detailed comments?

Ulf want you to s/SDHC/SDHCI in the line "If you have .....", I.E
change the line to:
If you have a machine with integrated Marvell Xenon SDHCI IP,

Thanks,
Jisheng
