From: will.deacon@arm.com (Will Deacon)
Date: Wed, 25 Jul 2018 13:17:46 +0100
Subject: [PATCH v2 0/7] Stop losing firmware-set DMA masks
In-Reply-To: <5e036ade-db0b-f628-a4a0-6d014d1d76c8@arm.com>
References: <cover.1532382222.git.robin.murphy@arm.com>
 <20180725113122.GD24736@lst.de>
 <5e036ade-db0b-f628-a4a0-6d014d1d76c8@arm.com>
Message-ID: <20180725121746.GD31576@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 25, 2018 at 01:12:56PM +0100, Robin Murphy wrote:
> On 25/07/18 12:31, Christoph Hellwig wrote:
> >Hi Robin,
> >
> >this series looks fine to me.  Do you want me to pull this into the
> >dma-mapping tree?  I'd like to see a few more ACKs from the ACPI/OF/
> >IOMMU maintainers though.
> 
> Thanks, I was indeed assuming that the dma-mapping tree would be the best
> route to keep this lot together, hence including patch #1 even though it's
> not functionally related (having spoken to Will offline I think he's happy
> for that one to go through you rather than via arm64 this time around, even
> if #2-#7 don't make it).

Yes, that's right. Here's my ack if it helps:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
