From: jg1.han@samsung.com (Jingoo Han)
Date: Tue, 01 Jul 2014 10:55:58 +0900
Subject: [PATCH RESEND] clk: samsung: Make of_device_id array const
In-Reply-To: <1403784006-17605-1-git-send-email-k.kozlowski@samsung.com>
References: <1403784006-17605-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <00a201cf94cf$9a8ee1b0$cfaca510$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, June 26, 2014 9:00 PM, Krzysztof Kozlowski wrote:
> 
> Array of struct of_device_id may be be const as expected by
> of_match_table field and of_find_matching_node_and_match() function.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Reviewed-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
>  drivers/clk/samsung/clk-exynos4.c    | 2 +-
>  drivers/clk/samsung/clk-exynos5250.c | 2 +-
>  drivers/clk/samsung/clk-exynos5420.c | 2 +-
>  drivers/clk/samsung/clk-exynos5440.c | 2 +-
>  drivers/clk/samsung/clk.c            | 2 +-
>  drivers/clk/samsung/clk.h            | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
> 
