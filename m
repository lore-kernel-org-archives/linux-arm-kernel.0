From: will.deacon@arm.com (Will Deacon)
Date: Wed, 18 Oct 2017 14:28:00 +0100
Subject: [PATCH 0/4] numa, iommu/smmu: IOMMU/SMMU driver optimization for
 NUMA systems
In-Reply-To: <20170921085922.11659-1-ganapatrao.kulkarni@cavium.com>
References: <20170921085922.11659-1-ganapatrao.kulkarni@cavium.com>
Message-ID: <20171018132759.GA21820@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ganapat,

On Thu, Sep 21, 2017 at 02:29:18PM +0530, Ganapatrao Kulkarni wrote:
> Adding numa aware memory allocations used for iommu dma allocation and
> memory allocated for SMMU stream tables, page walk tables and command queues.
> 
> With this patch, iperf testing on ThunderX2, with 40G NIC card on
> NODE 1 PCI shown same performance(around 30% improvement) as NODE 0.

Are you planning to repost this series? The idea looks good, but it needs
some rework before it can be merged.

Thanks,

Will
