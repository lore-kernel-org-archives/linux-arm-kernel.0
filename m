From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 18 Jun 2016 23:35:55 +0900
Subject: [PATCH] clk: samsung: exynos3250: Move PLL rates data to init
 section
In-Reply-To: <1462968736-7568-1-git-send-email-k.kozlowski@samsung.com>
References: <1462968134-6085-1-git-send-email-k.kozlowski@samsung.com>
 <1462968736-7568-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <CA+Ln22HyYd=SqBk_U1_zdiFmFc4tftEKYiibxnrtVA2cQZUX3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

2016-05-11 21:12 GMT+09:00 Krzysztof Kozlowski <k.kozlowski@samsung.com>:
> The arrays with initialization data of PLLs can be moved to initconst
> section because they are referenced only from other initconst-level
> symbols.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos3250.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Tomasz Figa <tomasz.figa@gmail.com>

Best regards,
Tomasz
