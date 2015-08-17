From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 17 Aug 2015 10:01:03 +0900
Subject: [PATCH 1/4] clk: samsung: exynos3250: Add UART2 clock
In-Reply-To: <1439264784-30322-2-git-send-email-cw00.choi@samsung.com>
References: <1439264784-30322-1-git-send-email-cw00.choi@samsung.com>
 <1439264784-30322-2-git-send-email-cw00.choi@samsung.com>
Message-ID: <55D1324F.1040908@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11.08.2015 12:46, Chanwoo Choi wrote:
> This patch add the UART2 clocks (mux, divider, gate) of Exynos3250 SoC.

I could not confirm the exact numbers used ("reserved" in my datasheet)
but the patch itself looks correct.

Assuming that numbers/addresses are good:
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>


Best regards,
Krzysztof

> 
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos3250.c   | 6 ++++++
>  include/dt-bindings/clock/exynos3250.h | 6 +++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
