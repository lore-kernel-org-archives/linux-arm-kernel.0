From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 3 Nov 2016 22:11:21 +0200
Subject: [PATCH v3 5/5] arm64: dts: exynos: Add dts file for
 Exynos5433-based TM2E board
In-Reply-To: <1478155149-28527-6-git-send-email-cw00.choi@samsung.com>
References: <1478155149-28527-1-git-send-email-cw00.choi@samsung.com>
 <1478155149-28527-6-git-send-email-cw00.choi@samsung.com>
Message-ID: <20161103201121.GC9379@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 03, 2016 at 03:39:09PM +0900, Chanwoo Choi wrote:
> This patch adds the Device Tree source for Exynos5433-based Samsung TM2E
> board. TM2E board is the most similar with TM2 board. The exynos5433-tm2e.dts
> include the difference between TM2 and TM2E.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> Signed-off-by: Inki Dae <inki.dae@samsung.com>
> Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> Signed-off-by: Hyungwon Hwang <human.hwang@samsung.com>
> Signed-off-by: Inha Song <ideal.song@samsung.com>
> Signed-off-by: Ingi kim <ingi2.kim@samsung.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
>  .../bindings/arm/samsung/samsung-boards.txt        |  1 +
>  arch/arm64/boot/dts/exynos/Makefile                |  1 +
>  arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts     | 41 ++++++++++++++++++++++
>  3 files changed, 43 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts
> 

Thanks, applied.

Best regards,
Krzysztof
