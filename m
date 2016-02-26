From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 26 Feb 2016 09:34:10 +0900
Subject: [PATCH] arm64: defconfig: Enable exynos thermal config
In-Reply-To: <1456371249-10244-1-git-send-email-alim.akhtar@samsung.com>
References: <1456371249-10244-1-git-send-email-alim.akhtar@samsung.com>
Message-ID: <56CF9D82.9090808@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25.02.2016 12:34, Alim Akhtar wrote:
> This patch enables exynos thermal and related configs for the
> TMU found on exynos7 SoC. This also enables thermal emulation
> mode to test trip points.
> 
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  arch/arm64/configs/defconfig |    3 +++
>  1 file changed, 3 insertions(+)

Thanks, applied.

Krzysztof
