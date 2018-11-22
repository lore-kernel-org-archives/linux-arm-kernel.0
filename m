From: will.deacon@arm.com (Will Deacon)
Date: Thu, 22 Nov 2018 13:35:26 +0000
Subject: [PATCH v3 00/15] MT8183 IOMMU SUPPORT
In-Reply-To: <20181122125931.GC1586@8bytes.org>
References: <1542422142-30688-1-git-send-email-yong.wu@mediatek.com>
 <20181122125931.GC1586@8bytes.org>
Message-ID: <20181122133526.GA13896@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 22, 2018 at 01:59:31PM +0100, Joerg Roedel wrote:
> On Sat, Nov 17, 2018 at 10:35:27AM +0800, Yong Wu wrote:
> > Yong Wu (14):
> >   dt-bindings: mediatek: Add binding for mt8183 IOMMU and SMI
> >   iommu/mediatek: Use a struct as the platform data
> >   memory: mtk-smi: Use a general config_port interface
> >   iommu/io-pgtable-arm-v7s: Add paddr_to_iopte and iopte_to_paddr
> >     helpers
> >   iommu/io-pgtable-arm-v7s: Extend MediaTek 4GB Mode
> >   iommu/mediatek: Add mt8183 IOMMU support
> >   iommu/mediatek: Add mmu1 support
> >   memory: mtk-smi: Invoke pm runtime_callback to enable clocks
> >   memory: mtk-smi: Use a struct for the platform data for smi-common
> >   memory: mtk-smi: Add bus_sel for mt8183
> >   iommu/mediatek: Add VLD_PA_RANGE register backup when suspend
> >   iommu/mediatek: Add shutdown callback
> >   memory: mtk-smi: Get rid of need_larbid
> >   iommu/mediatek: Switch to SPDX license identifier
> 
> This should probably go through the IOMMU tree. For that I'd like to
> have Acks (reviews are even better) for the io-pgtable parts from Robin
> and for the memory parts from Matthias first.

Robin already reviewed the pgtable bits, I think.

Will
