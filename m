From: andi.shyti@samsung.com (Andi Shyti)
Date: Fri, 08 Jul 2016 23:27:48 +0900
Subject: [PATCH v5] clk: exynos5433: remove CLK_IGNORE_UNUSED flag from SPI
 clocks
In-Reply-To: <577FA99C.9020600@samsung.com>
References: <1467982058-14339-1-git-send-email-andi.shyti@samsung.com>
 <CGME20160708132447epcas1p34cafe41f04b10ffa54bbd66813e656f6@epcas1p3.samsung.com>
 <577FA99C.9020600@samsung.com>
Message-ID: <20160708142748.GL23620@samsunx.samsung>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >  drivers/clk/samsung/clk-exynos5433.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> 
> Patch is okay:
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> but I think this should not go in separately. This should be part of
> SPI-related changes which add proper ioclk consumer to the SPI driver.
> Without these changes, as you said to me, synchronous abort will happen.

OK, I will send this patch with the SPI patchset.

Please ignore.

Thanks,
Andi
