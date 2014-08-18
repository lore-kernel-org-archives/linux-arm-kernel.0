From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 18 Aug 2014 13:26:17 +0200
Subject: [PATCH 03/29] clk: exynos: add missing smmu_g2d clock and update
 comments
In-Reply-To: <1407235677-26324-4-git-send-email-m.szyprowski@samsung.com>
References: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
 <1407235677-26324-4-git-send-email-m.szyprowski@samsung.com>
Message-ID: <53F1E2D9.7040101@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05.08.2014 12:47, Marek Szyprowski wrote:
> This patch adds missing smmu_g2d clock implementation and updates
> comment about Exynos4 clocks from 278-282 range. Those clocks are
> available on all Exynos4 SoC series, so the misleading comment has been
> removed.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos4.c   |  1 +
>  include/dt-bindings/clock/exynos4.h | 10 +++++-----
>  2 files changed, 6 insertions(+), 5 deletions(-)

Acked-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
