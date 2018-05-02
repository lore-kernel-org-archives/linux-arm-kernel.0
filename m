From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 2 May 2018 19:07:34 +0200
Subject: [RFC 10/10] ARM: exynos: Remove support for Exynos5440
In-Reply-To: <20180424203239.21885-11-krzk@kernel.org>
References: <20180424203239.21885-1-krzk@kernel.org>
 <20180424203239.21885-11-krzk@kernel.org>
Message-ID: <20180502170734.dghbjq4evn2pzha2@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2018 at 10:32:39PM +0200, Krzysztof Kozlowski wrote:
> The Exynos5440 is not actively developed, there are no development
> boards available and probably there are no real products with it.
> Remove wide-tree support for Exynos5440.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/mach-exynos/Kconfig  | 12 ------------
>  arch/arm/mach-exynos/common.h |  8 --------
>  arch/arm/mach-exynos/exynos.c | 15 ++-------------
>  3 files changed, 2 insertions(+), 33 deletions(-)
> 

Applied.

Best regards,
Krzysztof
