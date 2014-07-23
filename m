From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 23 Jul 2014 14:47:42 +0200
Subject: [PATCH v2 1/2] clk: samsung: exynos4: Enable ARMCLK down feature
In-Reply-To: <1405694193-29643-1-git-send-email-k.kozlowski@samsung.com>
References: <1405694193-29643-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <53CFAEEE.7040702@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 18.07.2014 16:36, Krzysztof Kozlowski wrote:
> Enable ARMCLK down feature on all Exynos4 SoCs. The frequency of
> ARMCLK will be reduced upon entering idle mode (WFI or WFE).

Will apply the whole series to Samsung clock tree.

Best regards,
Tomasz
