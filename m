From: andi@etezian.org (andi at etezian.org)
Date: Wed, 18 Apr 2018 03:09:39 +0900
Subject: [PATCH v2 4/8] spi: spi-s3c64xx: Drop unused enable_datapath()
 function argument
In-Reply-To: <20180417142954.5507-4-s.nawrocki@samsung.com>
References: <20180417142954.5507-1-s.nawrocki@samsung.com>
 <CGME20180417143039epcas2p39e2c730d107c94e5f9bf104d3a938f90@epcas2p3.samsung.com>
 <20180417142954.5507-4-s.nawrocki@samsung.com>
Message-ID: <749a25fcaf0ccaed931244dc8d381b98@etezian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylwester,

On 17.04.2018 23:29, Sylwester Nawrocki wrote:
> The spi pointer argument is not used now so remove it.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

Thanks for splitting it!

Reviewed-by: Andi Shyti <andi@etezian.org>

Andi
