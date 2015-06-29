From: will.deacon@arm.com (Will Deacon)
Date: Mon, 29 Jun 2015 18:28:31 +0100
Subject: [PATCH 6/8] iommu/arm-smmu: add support for non-pci devices
In-Reply-To: <1435307584-9812-7-git-send-email-thunder.leizhen@huawei.com>
References: <1435307584-9812-1-git-send-email-thunder.leizhen@huawei.com>
 <1435307584-9812-7-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <20150629172831.GL17474@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 26, 2015 at 09:33:02AM +0100, Zhen Lei wrote:
> Now, we only support a master with only one stream id. It will cover most
> hardware platforms and coding so easy.
> 
> Please refer Documentation\devicetree\bindings\iommu\iommu.txt on how to
> bind device tree.

Can you build this on top of Laurent's series, please?

  http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/343686.html

Will
