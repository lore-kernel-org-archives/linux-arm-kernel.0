From: will.deacon@arm.com (Will Deacon)
Date: Tue, 20 Jan 2015 15:21:15 +0000
Subject: [PATCH v6 8/8] arm: dma-mapping: plumb our iommu mapping ops
 into arch_setup_dma_ops
In-Reply-To: <20150120151910.GD1549@arm.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
 <1984907.uTqFPJnJpV@avalon> <20150119123058.GA7312@ulmo.nvidia.com>
 <2060841.mOvatXFir7@avalon> <20150120151910.GD1549@arm.com>
Message-ID: <20150120152115.GE1549@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 20, 2015 at 03:19:10PM +0000, Will Deacon wrote:
> We could restore the set_dma_ops call in arm_iommu_attach_device as a
> temporary hack (along with a big fat comment), since arch_setup_dma_ops
> actually sets the ops correct *after* the call to
> arm_get_iommu_dma_map_ops...

s/arm_get_iommu_dma_map_ops/arm_setup_iommu_dma_ops/

Will
