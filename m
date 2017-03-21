From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 21 Mar 2017 19:18:00 +0200
Subject: [PATCH v2 0/3] arm64: exynos: Enable drivers for Exynos5433
In-Reply-To: <20170314171028.20337-1-krzk@kernel.org>
References: <20170314171028.20337-1-krzk@kernel.org>
Message-ID: <20170321171800.6kn5efw425np4h7h@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 14, 2017 at 07:10:25PM +0200, Krzysztof Kozlowski wrote:
> Hi,
> 
> 
> Patches are independent but I organized them into one patchset
> as they have common goal - enable more drivers for ARMv8 Exynos chips.
> 
> If there are no objections, I can take it through samsung-soc.
> 
> Changes since v1:
> ================
> 1. Patch 1/3: Do not enable entire DRM stack but only drivers
>    supporting Exynos5433 and Exynos7 (suggested by Bartlomiej).
> 2. Add Bartlomiej's and Alim's reviews.
> 
> 
> Best regards,
> Krzysztof
>

I appled all three to samsung-soc and I will push them through arm-soc.

Best regards,
Krzysztof
