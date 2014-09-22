From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 22 Sep 2014 14:09:34 +0200
Subject: [PATCH v2 04/18] clk: exynos: add missing smmu_g2d clock and
 update comments
In-Reply-To: <1410868485-4143-5-git-send-email-m.szyprowski@samsung.com>
References: <1410868485-4143-1-git-send-email-m.szyprowski@samsung.com>
 <1410868485-4143-5-git-send-email-m.szyprowski@samsung.com>
Message-ID: <5420117E.9030108@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.09.2014 13:54, Marek Szyprowski wrote:
> This patch adds missing smmu_g2d clock implementation and updates
> comment about Exynos4 clocks from 278-282 range. Those clocks are
> available on all Exynos4 SoC series, so the misleading comment has been
> removed.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Tomasz Figa <t.figa@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos4.c   |  1 +
>  include/dt-bindings/clock/exynos4.h | 10 +++++-----
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 

Applied for next.

Best regards,
Tomasz
