From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Nov 2015 11:33:45 +0100
Subject: [PATCH] SPI: s3c64xx: pass DMA arguments in platform data
In-Reply-To: <8391350.6B0EUH1WXO@wuerfel>
References: <8391350.6B0EUH1WXO@wuerfel>
Message-ID: <16591294.iqvGkiFfez@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 16 November 2015 17:00:21 Arnd Bergmann wrote:
> The s3c64xx platform data already contains a pointer to the
> DMA filter function, but not to the associated data.
> 
> This simplifies the code and makes it more generic by
> passing the data along with the filter function like
> we do for other drivers.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

While rebasing the ASoC patches, I realized that they are not independent
of this one, which I did on top of the others.

None of them are urgent, so if the maintainers all agree that we want them,
I can wait another merge window with this one. Alternatively, I could
rework the patches to avoid the dependency, or we could merge them
all through the samsung git tree in order.

	Arnd
