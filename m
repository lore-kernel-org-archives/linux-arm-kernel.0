From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 28 Nov 2016 13:49:29 +0530
Subject: [PATCH v2 2/3] ARM: davinci: da850-evm: use gpio descriptor for
 mmc pins
In-Reply-To: <20161124150454.23899-3-ahaslam@baylibre.com>
References: <20161124150454.23899-1-ahaslam@baylibre.com>
 <20161124150454.23899-3-ahaslam@baylibre.com>
Message-ID: <d3b10abc-4b7f-c30b-18e0-40a7a913ff64@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 24 November 2016 08:34 PM, Axel Haslam wrote:
> Currently the mmc driver is polling the gpio to know if the
> card was removed.
> 
> By using a gpio descriptor instead of the platform callbacks,
> the driver will be able to register the gpio using the mmc core
> API's designed for this purpose.
> 
> This has the advantage that an irq will be registered, and
> polling is no longer needed. Also, a dependency on platform
> callbacks is removed for this board.
> 
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>

Applied.

Thanks,
Sekhar
