From: hch@lst.de (Christoph Hellwig)
Date: Thu, 20 Jul 2017 16:11:09 +0200
Subject: [PATCH 1/2] drivers: dma-coherent: Introduce interface for
 default DMA pool
In-Reply-To: <d955cf45-1de4-91c5-6967-dcf46732abf6@arm.com>
References: <1500545999-17177-1-git-send-email-vladimir.murzin@arm.com>
 <1500545999-17177-2-git-send-email-vladimir.murzin@arm.com>
 <d955cf45-1de4-91c5-6967-dcf46732abf6@arm.com>
Message-ID: <20170720141109.GA14234@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 20, 2017 at 02:45:26PM +0100, Robin Murphy wrote:
> I'd have left the factored-out static helpers named __*_from_coherent(),
> as the _dev is not strictly true there, but it really doesn't matter as
> far as I'm concerned:

I've fixed that and a few other minor style bits up, and applied it
to the dma-mapping tree.  If all goes right I'll send it to Linus
on Saturday.
