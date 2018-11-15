From: will.deacon@arm.com (Will Deacon)
Date: Thu, 15 Nov 2018 19:50:41 +0000
Subject: move the arm arch_dma_alloc implementation to common code
In-Reply-To: <20181109075238.GA27578@lst.de>
References: <20181105121931.13481-1-hch@lst.de> <20181109075238.GA27578@lst.de>
Message-ID: <20181115195041.GC4535@brain-police>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 09, 2018 at 08:52:38AM +0100, Christoph Hellwig wrote:
> Can I get a quick review from the arm64 folks?  I think it should
> be fine there as it basically is a code move, but an additional pair
> or two of eyes always helps to weed out bugs.

I reviewed the arm64 parts, but it would be ideal if Robin could have a look
as well.

Will
