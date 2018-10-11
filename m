From: adam.cottrel@veea.com (Adam Cottrel)
Date: Thu, 11 Oct 2018 12:34:07 +0000
Subject: Pros and Cons of IOMMU (vs SWIOTLB)
Message-ID: <DM6PR04MB4059A2D8891052FA5DBC051AF2E10@DM6PR04MB4059.namprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I have just enabled IOMMU support on my ARM Cavium SoC within the DT. However, I cannot see any benefits (or disadvantages) of doing so...

Can anyone tell me the benefits of using a hardware IOMMU (vs SWIOTLB) for DMA transfers?

Best,
Adam
