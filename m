From: hch@lst.de (Christoph Hellwig)
Date: Wed, 10 Jan 2018 16:40:50 +0100
Subject: [PATCH 11/33] dma-mapping: move swiotlb arch helpers to a new
 header
In-Reply-To: <b0f90ed0-989f-4dc2-6f86-de8b4e486b55@arm.com>
References: <20180110080027.13879-1-hch@lst.de>
 <20180110080027.13879-12-hch@lst.de>
 <3721b4ba-0685-255e-06b9-6e60678a1a92@arm.com>
 <20180110152617.GB17790@lst.de>
 <b0f90ed0-989f-4dc2-6f86-de8b4e486b55@arm.com>
Message-ID: <20180110154050.GA18428@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 10, 2018 at 03:31:08PM +0000, Robin Murphy wrote:
> Yes indeed, modulo Vladimir's comments - it does seem prudent to fix the 
> obvious off-by-ones as we touch them. I've wanted to do something like this 
> for ages, but never got around to it myself.

I've fixed these now in a separate patch.  I'm taking this as an
Acked-by.
