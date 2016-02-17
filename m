From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 17 Feb 2016 11:03:36 +0100
Subject: [PATCH v5 2/3] clk: samsung: Don't build ARMv8 clock drivers on
 ARMv7
In-Reply-To: <1455603632-11158-3-git-send-email-k.kozlowski@samsung.com>
References: <1455603632-11158-1-git-send-email-k.kozlowski@samsung.com>
 <1455603632-11158-3-git-send-email-k.kozlowski@samsung.com>
Message-ID: <56C44578.5010009@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/02/16 07:20, Krzysztof Kozlowski wrote:
> Currently the Exynos5433 (ARMv8 SoC) clock driver depends on ARCH_EXYNOS
> so it is built also on ARMv7. This does not bring any kind of benefit.
> There won't be a single kernel image for ARMv7 and ARMv8 SoCs (like
> multi_v7 for ARMv7).
> 
> Instead build clock drivers only for respective SoC's architecture.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
