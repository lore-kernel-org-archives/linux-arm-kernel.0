From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Sep 2012 14:43:28 +0000
Subject: [PATCH v2] spi/pl022: Devicetree support w/o platform data
In-Reply-To: <1347976433-1176-1-git-send-email-stigge@antcom.de>
References: <1347976433-1176-1-git-send-email-stigge@antcom.de>
Message-ID: <201209181443.29025.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 September 2012, Roland Stigge wrote:
> Even with devicetree support, we needed platform data to provide some data,
> leading to mixed device tree and platform data. This patch makes it possible to
> provide all that information via device tree. Now, the data must be provided
> via platform data or device tree completely.
> 
> Only in case of DMA where a callback specification is necessary (dma_filter()),
> platform data is the only option.
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>
