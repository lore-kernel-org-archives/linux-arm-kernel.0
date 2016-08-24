From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 24 Aug 2016 06:43:29 +0200
Subject: [PATCH] ARM: EXYNOS: Remove unused DMC offset and its mapping
In-Reply-To: <1471931416-15991-1-git-send-email-pankaj.dubey@samsung.com>
References: <1471931416-15991-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <20160824044329.GA8407@kozik-book>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2016 at 11:20:16AM +0530, Pankaj Dubey wrote:
> Currently there is no user of DMC SFR offsets, so we can safely remove
> mapping of its SFR address space and cleanup related offset macros from
> mach-exynos.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  arch/arm/mach-exynos/exynos.c                | 10 ----------
>  arch/arm/mach-exynos/include/mach/map.h      |  3 ---
>  arch/arm/plat-samsung/include/plat/map-s5p.h |  3 ---
>  3 files changed, 16 deletions(-)
>

Thanks, applied.

Best regards,
Krzysztof
