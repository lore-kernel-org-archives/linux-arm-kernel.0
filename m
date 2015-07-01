From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 02 Jul 2015 08:58:33 +0900
Subject: [PATCH v5 3/3] ARM: exynos: Add exynos3250 compatible to use
 generic cpufreq driver
In-Reply-To: <1435756877-26736-4-git-send-email-cw00.choi@samsung.com>
References: <1435756877-26736-1-git-send-email-cw00.choi@samsung.com>
 <1435756877-26736-4-git-send-email-cw00.choi@samsung.com>
Message-ID: <55947EA9.60204@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01.07.2015 22:21, Chanwoo Choi wrote:
> This patch add exynos3250 compatible string to exynos_cpufreq_matches
> for supporting generic cpufreq driver on Exynos3250.
> 
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-exynos/exynos.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
