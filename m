From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 8 Jun 2012 07:45:41 +0800
Subject: [PATCH 3/3] ASoC: follow the updated samsung DMA common operations
In-Reply-To: <011701cd42eb$a4209940$ec61cbc0$%kim@samsung.com>
References: <011701cd42eb$a4209940$ec61cbc0$%kim@samsung.com>
Message-ID: <20120607234540.GU14525@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 05, 2012 at 04:20:10PM +0900, Boojin Kim wrote:
> This patch uses config() function to configure DMA transmit options.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

It'd be good if we could get all the older Samsung platforms moved over
to dmaengine...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120608/bd3be1c9/attachment.sig>
