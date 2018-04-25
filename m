From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 25 Apr 2018 14:49:41 +0200
Subject: [RFC 08/10] spi: s3c64xx: samsung: Remove support for Exynos5440
In-Reply-To: <20180424203239.21885-9-krzk@kernel.org>
References: <20180424203239.21885-1-krzk@kernel.org>
 <CGME20180424203409epcas2p45f55e5a5d211e78d4cadc3c4ffa5a9c0@epcas2p4.samsung.com>
 <20180424203239.21885-9-krzk@kernel.org>
Message-ID: <066e917b-7207-9c10-4d6c-07273c6f49d9@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/24/2018 10:32 PM, Krzysztof Kozlowski wrote:
> The Exynos5440 is not actively developed, there are no development
> boards available and probably there are no real products with it.
> Remove wide-tree support for Exynos5440.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

It's good you didn't remove S3C64XX_SPI_QUIRK_POLL entirely as it will
be needed for Exynos5433 ISP SPI controllers.

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
