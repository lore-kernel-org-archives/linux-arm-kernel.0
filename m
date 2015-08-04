From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Tue, 4 Aug 2015 10:43:06 +0000
Subject: [PATCH v5 2/5] PCI: designware: Add ARM64 support
In-Reply-To: <55C09694.30506@arm.com>
References: <1437794486-21134-1-git-send-email-wangzhou1@hisilicon.com>
 <1437794486-21134-3-git-send-email-wangzhou1@hisilicon.com>
 <55B71F75.5030907@hisilicon.com> <55C0872E.9060507@arm.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E01D719E9@lhreml503-mbs>
 <55C09694.30506@arm.com>
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E01D71A2D@lhreml503-mbs>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: James Morse [mailto:james.morse at arm.com]
> Sent: Tuesday, August 04, 2015 11:40 AM
> To: Gabriele Paoloni; Wangzhou (B)
> Cc: Bjorn Helgaas; Jingoo Han; Pratyush Anand; Arnd Bergmann; Lorenzo
> Pieralisi; Liviu Dudau; thomas.petazzoni at free-electrons.com; Jason
> Cooper; robh at kernel.org; linux-pci at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; devicetree at vger.kernel.org; Yuanzhichang;
> Zhudacai; zhangjukuo; qiuzhenfa; liudongdong (C); qiujiang;
> Kangfenglong; Liguozhu (Kenneth)
> Subject: Re: [PATCH v5 2/5] PCI: designware: Add ARM64 support
> 
> On 04/08/15 11:23, Gabriele Paoloni wrote:
> > Hi James
> >
> > Please see "[PATCH v6] PCI: Store PCIe bus address in struct
> of_pci_range"
> >
> > I think if you apply this patch your problem should be solved...
> >
> > If you follow the discussion you see that this patch is going to be
> part
> > of the next designware patchset...
> 
> Yes I just spotted that series after continuing through my email
> backlog.
> 
> > Wang Zhou said "You need apply Gabriele's patch before applying this
> patch."
> > but he didn't specify which one and obviously this patch should have
> been part
> > of the patch-set
> 
> I assumed he meant your patch 1 in the same series, (given the reply
> was to
> patch 2).
> 
> With the '[PATCH v6] PCI: Store PCIe bus address in struct
> of_pci_range'
> applied before patches and 1 and 2 of this series - pcie on the
> 'Freescale i.MX6 Quad SABRE Lite Board' works fine.
> 
> I can rescan the bus, load firmware, list nearby APs, and even get MSIs
> coming from the card.

This is Great NEWS! Thanks a Lot!

> 
> Tested-by: James Morse <james.morse@arm.com>
> 
> 
> 
> James
