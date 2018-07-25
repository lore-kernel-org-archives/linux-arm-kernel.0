From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 25 Jul 2018 13:12:56 +0100
Subject: [PATCH v2 0/7] Stop losing firmware-set DMA masks
In-Reply-To: <20180725113122.GD24736@lst.de>
References: <cover.1532382222.git.robin.murphy@arm.com>
 <20180725113122.GD24736@lst.de>
Message-ID: <5e036ade-db0b-f628-a4a0-6d014d1d76c8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/07/18 12:31, Christoph Hellwig wrote:
> Hi Robin,
> 
> this series looks fine to me.  Do you want me to pull this into the
> dma-mapping tree?  I'd like to see a few more ACKs from the ACPI/OF/
> IOMMU maintainers though.

Thanks, I was indeed assuming that the dma-mapping tree would be the 
best route to keep this lot together, hence including patch #1 even 
though it's not functionally related (having spoken to Will offline I 
think he's happy for that one to go through you rather than via arm64 
this time around, even if #2-#7 don't make it).

Robin.
