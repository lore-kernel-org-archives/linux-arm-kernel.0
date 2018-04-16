From: andi@etezian.org (andi at etezian.org)
Date: Tue, 17 Apr 2018 04:09:01 +0900
Subject: [PATCH 3/6] spi: spi-s3c64xx: Drop unused enable_datapath()
 function argument
In-Reply-To: <20180416154021.25626-3-s.nawrocki@samsung.com>
References: <20180416154021.25626-1-s.nawrocki@samsung.com>
 <CGME20180416154122epcas1p1ae714af12f8da08783c47fcd820c40e7@epcas1p1.samsung.com>
 <20180416154021.25626-3-s.nawrocki@samsung.com>
Message-ID: <167c0f1a1a9de44574523c7f4a9d137d@etezian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylwester,

On 17.04.2018 00:40, Sylwester Nawrocki wrote:
> The spi pointer argument is not used now so remove it. While at it
> s3c64xx_ prefix is added to the function name.

These for me are two different patches, but in any case it's trivial
so that I don't mind it too much.

> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

Reviewed-by: Andi Shyti <andi@etezian.org>

Thanks,
Andi
