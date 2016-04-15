From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 15 Apr 2016 11:05:54 +0200
Subject: [PATCH v2 6/8] clk: samsung: exynos542x: Add the clock id for ACLK
In-Reply-To: <1460701975-24178-7-git-send-email-cw00.choi@samsung.com>
References: <1460701975-24178-1-git-send-email-cw00.choi@samsung.com>
 <1460701975-24178-7-git-send-email-cw00.choi@samsung.com>
Message-ID: <5710AEF2.3040800@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/2016 08:32 AM, Chanwoo Choi wrote:
> This patch adds the clock id for ACLK clock which is source clock of AMBA AXI
> Bus. This clock should be handled in Bus frequency scaling driver.
> 
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Tested-by: Markus Reichl <m.reichl@fivetechno.de>
> Tested-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  drivers/clk/samsung/clk-exynos5420.c | 77 ++++++++++++++++++++++--------------
>  1 file changed, 47 insertions(+), 30 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
