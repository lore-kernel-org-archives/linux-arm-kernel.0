From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 3 May 2018 18:22:18 +0200
Subject: [PATCH] ARM: EXYNOS: no need to select ARCH_HAS_BANDGAP any longer
In-Reply-To: <9721484.FBO9LEPOs5@amdc3058>
References: <CGME20180502143026eucas1p144f0f581196615d9c0fba89a562e6e12@eucas1p1.samsung.com>
 <9721484.FBO9LEPOs5@amdc3058>
Message-ID: <20180503162218.47umsrz3hiphxw4y@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 02, 2018 at 04:30:26PM +0200, Bartlomiej Zolnierkiewicz wrote:
> This is not needed since commit fcbb1e02ee54 ("drivers: thermal:
> Remove ARCH_HAS_BANDGAP dependency for samsung") from 2014.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm/mach-exynos/Kconfig |    1 -
>  1 file changed, 1 deletion(-)
> 

Thanks, applied.

Best regards,
Krzysztof
