From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 2 Jan 2017 20:37:11 +0200
Subject: [PATCH v2 5/5] arm64: dts: exynos5433: Add support of bus
 frequency using VDD_INT on TM2
In-Reply-To: <1481173091-9728-6-git-send-email-cw00.choi@samsung.com>
References: <1481173091-9728-1-git-send-email-cw00.choi@samsung.com>
 <1481173091-9728-6-git-send-email-cw00.choi@samsung.com>
Message-ID: <20170102183711.jl2tznpaxgwakwhc@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 08, 2016 at 01:58:11PM +0900, Chanwoo Choi wrote:
> This patch adds the bus Device-tree nodes for INT (Internal) block
> to enable the bus frequency scaling.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433-tm2.dts | 70 +++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 
Thanks, applied.

Best regards,
Krzysztof
