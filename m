From: boojin.kim@samsung.com (Boojin Kim)
Date: Tue, 19 Jun 2012 15:30:00 +0900
Subject: [PATCH 3/3] ASoC: follow the updated samsung DMA common operations
In-Reply-To: <20120607234540.GU14525@opensource.wolfsonmicro.com>
References: <011701cd42eb$a4209940$ec61cbc0$%kim@samsung.com>
 <20120607234540.GU14525@opensource.wolfsonmicro.com>
Message-ID: <011101cd4de4$f41f59f0$dc5e0dd0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote
> > This patch uses config() function to configure DMA transmit options.
>
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>
> It'd be good if we could get all the older Samsung platforms moved over to dmaengine...
Thanks for your ack :)
And, Our engineer's preparing to move the older Samsung dma driver into dmaengine.
