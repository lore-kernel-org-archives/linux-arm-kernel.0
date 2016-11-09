From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 9 Nov 2016 22:04:32 +0200
Subject: [PATCH v3 2/2] ARM: EXYNOS: Remove unused soc_is_exynos{4,5}
In-Reply-To: <1478693755-11953-3-git-send-email-pankaj.dubey@samsung.com>
References: <1478693755-11953-1-git-send-email-pankaj.dubey@samsung.com>
 <1478693755-11953-3-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <20161109200432.GB23534@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 09, 2016 at 05:45:55PM +0530, Pankaj Dubey wrote:
> As no more user of soc_is_exynos{4,5} we can safely remove them.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  arch/arm/mach-exynos/common.h | 5 -----
>  1 file changed, 5 deletions(-)
>

Thanks, applied.

Best regards,
Krzysztof
