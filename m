From: robh@kernel.org (Rob Herring)
Date: Thu, 18 Aug 2016 14:10:08 -0500
Subject: [PATCH 7/7] arm64: dts: exynos: Add dts file for
 Exynos5433-based TM2E board
In-Reply-To: <1471329328-26842-3-git-send-email-cw00.choi@samsung.com>
References: <1471328843-26653-1-git-send-email-cw00.choi@samsung.com>
 <1471329328-26842-3-git-send-email-cw00.choi@samsung.com>
Message-ID: <20160818191008.GA18429@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2016 at 03:35:28PM +0900, Chanwoo Choi wrote:
> This patcha adds the Device Tree source for Exynos5433-based Samsung TM2E
> board. TM2E board is the most similiar with TM2 board. The exynos5433-tm2e.dts
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
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  .../bindings/arm/samsung/samsung-boards.txt        |  1 +
>  arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts     | 41 ++++++++++++++++++++++
>  2 files changed, 42 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts

Acked-by: Rob Herring <robh@kernel.org>
