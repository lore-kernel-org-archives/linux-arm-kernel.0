From: hch@lst.de (Christoph Hellwig)
Date: Wed, 19 Jul 2017 09:21:40 +0200
Subject: [RFC PATCH 2/2] ARM: NOMMU: Wire-up default DMA interface
In-Reply-To: <1500281885-3034-3-git-send-email-vladimir.murzin@arm.com>
References: <1500281885-3034-1-git-send-email-vladimir.murzin@arm.com>
 <1500281885-3034-3-git-send-email-vladimir.murzin@arm.com>
Message-ID: <20170719072140.GB20840@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 17, 2017 at 09:58:05AM +0100, Vladimir Murzin wrote:
> The way how default DMA pool is exposed has changed and now we need to
> use dedicated interface to work with it. This patch makes alloc/release
> operations to use such interface. Since default DMA pool is not
> handled by generic code anymore we have to implement our own mmap
> operation.

Looks good to me.
