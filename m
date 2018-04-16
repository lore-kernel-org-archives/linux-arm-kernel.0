From: andi@etezian.org (andi at etezian.org)
Date: Tue, 17 Apr 2018 04:06:31 +0900
Subject: [PATCH 2/6] spi: spi-s3c64xx: Remove unused s3c64xx_spi_hwinit()
 function argument
In-Reply-To: <20180416154021.25626-2-s.nawrocki@samsung.com>
References: <20180416154021.25626-1-s.nawrocki@samsung.com>
 <CGME20180416154109epcas2p1696b9cdc72403fe5abdd0a2117067c8d@epcas2p1.samsung.com>
 <20180416154021.25626-2-s.nawrocki@samsung.com>
Message-ID: <d4ccf19bd88c45c50f4026d6e08951c7@etezian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylwester,

On 17.04.2018 00:40, Sylwester Nawrocki wrote:
> The channel argument is not used and anyway it could be retrieved from
> the passed driver data structure.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

Reviewed-by: Andi Shyti <andi@etezian.org>

Thanks,
Andi
