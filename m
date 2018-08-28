From: hch@lst.de (Christoph Hellwig)
Date: Tue, 28 Aug 2018 09:02:17 +0200
Subject: [PATCH] ARM: wire up io_pgetevents syscall
In-Reply-To: <20180827200505.21991-1-stefan@agner.ch>
References: <20180827200505.21991-1-stefan@agner.ch>
Message-ID: <20180828070217.GA10549@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 27, 2018 at 10:05:05PM +0200, Stefan Agner wrote:
> Wire up the new io_pgetevents syscall for ARM.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Looks good to me:

Acked-by: Christoph Hellwig <hch@lst.de>
