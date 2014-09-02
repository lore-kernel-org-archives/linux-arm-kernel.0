From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 02 Sep 2014 21:11:34 +0200
Subject: [RFC PATCH v2 0/7] Introduce automatic DMA configuration for
 IOMMU masters
In-Reply-To: <1409680587-29818-1-git-send-email-will.deacon@arm.com>
References: <1409680587-29818-1-git-send-email-will.deacon@arm.com>
Message-ID: <4732768.tUfgnsJBJp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 02 September 2014 18:56:20 Will Deacon wrote:
> The main difference since v1 is that I've introduced some generic
> structures to represent IOMMUs and their mappings (struct iommu_data and
> struct iommu_dma_mapping). This allows us to propagate the per-instance
> data all the way down to the DMA-mapping code, which can then manage a
> per-instance domain. Note that the ARM dma-mapping implementation does
> not currently make use of this information.
> 

Overall I'm pretty happy with how this is turning out so far.
I have commented on a few patches, everything else looks good to
me.

	Arnd
