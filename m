From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 28 Aug 2013 15:08:20 +0200
Subject: [PATCH 0/2] Exynos5 device tree fixes
In-Reply-To: <1377693768-16777-1-git-send-email-chander.kashyap@linaro.org>
References: <1377693768-16777-1-git-send-email-chander.kashyap@linaro.org>
Message-ID: <1616805.Bvb6ibvgpm@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 28 of August 2013 18:12:46 Chander Kashyap wrote:
> This patch series fixes two problem with MCT node in Exynos5 platforms.
> 1. In Exynos5250 it fixes the number of interrupt-cells.
> 2. Removes invalid properties in MCT node for Exynos5420 and Exynos5250.
> 
> Chander Kashyap (2):
>   ARM: DT: Exynos5250: fix number of interrupt-cells in mct node
>   DTS: Exynos5: Remove invalid MCT properties
> 
>  arch/arm/boot/dts/exynos5250.dtsi |   19 ++++++++-----------
>  arch/arm/boot/dts/exynos5420.dtsi |    2 --
>  2 files changed, 8 insertions(+), 13 deletions(-)

For the whole series:

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

By the way, it should be noted that this patch is a follow up to my series, 
available at:

http://thread.gmane.org/gmane.linux.kernel.samsung-soc/22207

to let reviewing people know that things that this patch relies on, like 
relevant changes to the documentation, have been already posted.

Best regards,
Tomasz
