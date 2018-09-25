From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 25 Sep 2018 09:48:41 +0200
Subject: [PATCH 0/7 v7] Support for fsl-mc bus and its devices in SMMU
In-Reply-To: <1536587361-11047-1-git-send-email-nipun.gupta@nxp.com>
References: <1536587361-11047-1-git-send-email-nipun.gupta@nxp.com>
Message-ID: <20180925074841.oukeyvrmub45kzis@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2018 at 07:19:14PM +0530, Nipun Gupta wrote:
> Nipun Gupta (7):
>   Documentation: fsl-mc: add iommu-map device-tree binding for fsl-mc
>     bus
>   iommu/of: make of_pci_map_rid() available for other devices too
>   iommu/of: support iommu configuration for fsl-mc devices
>   iommu/arm-smmu: Add support for the fsl-mc bus
>   bus: fsl-mc: support dma configure for devices on fsl-mc bus
>   bus: fsl-mc: set coherent dma mask for devices on fsl-mc bus
>   arm64: dts: ls208xa: comply with the iommu map binding for fsl_mc

Applied, thanks Nipun.
