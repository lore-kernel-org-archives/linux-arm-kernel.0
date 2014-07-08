From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 08 Jul 2014 15:06:11 +0200
Subject: [PATCH RESEND] clk: samsung: Make of_device_id array const
In-Reply-To: <1403784006-17605-1-git-send-email-k.kozlowski@samsung.com>
References: <1403784006-17605-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <53BBECC3.9020202@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 26.06.2014 14:00, Krzysztof Kozlowski wrote:
> Array of struct of_device_id may be be const as expected by
> of_match_table field and of_find_matching_node_and_match() function.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos4.c    | 2 +-
>  drivers/clk/samsung/clk-exynos5250.c | 2 +-
>  drivers/clk/samsung/clk-exynos5420.c | 2 +-
>  drivers/clk/samsung/clk-exynos5440.c | 2 +-
>  drivers/clk/samsung/clk.c            | 2 +-
>  drivers/clk/samsung/clk.h            | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
> 

Thanks for the patch. Will apply.

Best regards,
Tomasz
