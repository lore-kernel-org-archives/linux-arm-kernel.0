From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 17 Aug 2015 10:48:05 +0900
Subject: [PATCH 2/4] clk: samsung: exynos3250: Add MMC2 clock
In-Reply-To: <1439264784-30322-3-git-send-email-cw00.choi@samsung.com>
References: <1439264784-30322-1-git-send-email-cw00.choi@samsung.com>
 <1439264784-30322-3-git-send-email-cw00.choi@samsung.com>
Message-ID: <55D13D55.5030207@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11.08.2015 12:46, Chanwoo Choi wrote:
> This patch add the MMC2 clocks (mux, divider, gate) of Exynos3250 SoC.
> 
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos3250.c   | 9 +++++++++
>  include/dt-bindings/clock/exynos3250.h | 7 ++++++-
>  2 files changed, 15 insertions(+), 1 deletion(-)



Assuming that numbers/addresses are good (reserved in my datasheet) the
code itself looks good:
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>


Best regards,
Krzysztof
