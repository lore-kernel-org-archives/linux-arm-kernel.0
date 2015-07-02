From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 02 Jul 2015 09:05:04 +0900
Subject: [PATCH v5 1/3] clk: samsung: exynos3250: Add cpu clock
 configuration data and instaniate cpu clock
In-Reply-To: <1435756877-26736-2-git-send-email-cw00.choi@samsung.com>
References: <1435756877-26736-1-git-send-email-cw00.choi@samsung.com>
 <1435756877-26736-2-git-send-email-cw00.choi@samsung.com>
Message-ID: <55948030.3010700@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01.07.2015 22:21, Chanwoo Choi wrote:
> This patch add CPU clock configuration data and instantiate the CPU clock type
> for Exynos3250 to support Samsung specific cpu-clock type.
> 
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos3250.c   | 32 ++++++++++++++++++++++++++++++--
>  include/dt-bindings/clock/exynos3250.h |  1 +
>  2 files changed, 31 insertions(+), 2 deletions(-)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
