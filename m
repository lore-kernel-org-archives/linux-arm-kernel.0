From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 11 Jul 2016 12:58:28 +0200
Subject: [PATCH v2 7/7] clk: exynos5433: remove CLK_IGNORE_UNUSED flag from
 SPI clocks
In-Reply-To: <1467989201-14661-8-git-send-email-andi.shyti@samsung.com>
References: <1467989201-14661-1-git-send-email-andi.shyti@samsung.com>
 <1467989201-14661-8-git-send-email-andi.shyti@samsung.com>
Message-ID: <57837BD4.5030602@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/08/2016 04:46 PM, Andi Shyti wrote:
> Because the Exynos5433 SPI driver supports the ioclk handling and
> the following patch:
> 
>   http://marc.info/?l=linux-kernel&m=146787645626318&w=2
> 
> fixes a synchronus abort issue, none of the SPI clocks require
s/synchronus/synchronous

> any critical handling: remove, then, the CLK_IGNORE_UNUSED flag
> for the SPI related clocks.
> 
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

In case this goes through the spi tree:
Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
