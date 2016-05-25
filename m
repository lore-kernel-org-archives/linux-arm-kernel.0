From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 25 May 2016 11:34:20 +0200
Subject: [PATCH 3/3] clk: samsung: exynos5433: add CPU clocks configuration
 data and instantiate CPU clocks
In-Reply-To: <1464095957-25851-4-git-send-email-b.zolnierkie@samsung.com>
References: <1464095957-25851-1-git-send-email-b.zolnierkie@samsung.com>
 <1464095957-25851-4-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <5745719C.4000106@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/24/2016 03:19 PM, Bartlomiej Zolnierkiewicz wrote:
> Add the CPU clocks configuration data and instantiate the CPU clocks
> type for Exynos5433.
> 
> Cc: Kukjin Kim <kgene@kernel.org>
> CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5433.c | 72 ++++++++++++++++++++++++++++++++----
>  1 file changed, 64 insertions(+), 8 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
