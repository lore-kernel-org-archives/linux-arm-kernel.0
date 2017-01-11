From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 11 Jan 2017 18:26:13 +0200
Subject: [PATCH] arm64: dts: exynos: Replace small letter of base
 address/offset on Exynos5433
In-Reply-To: <1484096148-17120-1-git-send-email-cw00.choi@samsung.com>
References: <CGME20170111005552epcas1p4a1f6ed88022b46544dec4b3801583267@epcas1p4.samsung.com>
 <1484096148-17120-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <20170111162613.lxkc7k75f6q3fsz2@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2017 at 09:55:48AM +0900, Chanwoo Choi wrote:
> This patch replaces the small letter of base address, offset and hex value
> with the capital letter to keep the consistency on Exynos5433.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433.dtsi | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> index abaf6b4d599d..d7ed1a68b6fd 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> @@ -231,7 +231,7 @@
>  		compatible = "arm,psci";
>  		method = "smc";
>  		cpu_off = <0x84000002>;
> -		cpu_on = <0xC4000003>;
> +		cpu_on = <0xc4000003>;

There is no point of such "improvements". This is just unnecessary
churn.

Sometimes such things are accepted as part of some bigger work (vide
recent Andrzej's sysmmu for HDMI/TV). But on its own? No sense at all.

Best regards,
Krzysztof
