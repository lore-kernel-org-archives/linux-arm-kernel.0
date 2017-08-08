From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 8 Aug 2017 17:44:04 +0200
Subject: [PATCH v7 2/4] clk: samsung: Add support for runtime PM
In-Reply-To: <1501839294-478-3-git-send-email-m.szyprowski@samsung.com>
References: <1501839294-478-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170804093515eucas1p1cc2273ba02d86767c5b2533430577698@eucas1p1.samsung.com>
 <1501839294-478-3-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20170808154404.GB2646@kozik-book>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 04, 2017 at 11:34:52AM +0200, Marek Szyprowski wrote:
> This patch adds struct device pointer to samsung_clk_provider and forwarding it
> to clk_register_* functions, so drivers can register clocks, which use runtime
> pm feature.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/clk/samsung/clk-pll.c |  2 +-
>  drivers/clk/samsung/clk.c     | 12 ++++++------
>  drivers/clk/samsung/clk.h     |  1 +
>  3 files changed, 8 insertions(+), 7 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
