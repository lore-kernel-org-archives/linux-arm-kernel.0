From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 2 Jun 2016 09:54:08 -0400
Subject: [PATCH 4/4] ARM: exynos_defconfig: Save defconfig on current
 linux-next
In-Reply-To: <1464846916-3110-4-git-send-email-k.kozlowski@samsung.com>
References: <1464846916-3110-1-git-send-email-k.kozlowski@samsung.com>
 <1464846916-3110-4-git-send-email-k.kozlowski@samsung.com>
Message-ID: <f5faaac7-7e26-b1fa-4327-fb3e4daee754@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 06/02/2016 01:55 AM, Krzysztof Kozlowski wrote:
> Save defconfig on next-20160602. Most of changes are just re-ordering of
> symbols.  Removed symbols:
>  - FHANDLE (default y),
>  - THERMAL, EXYNOS_THERMAL (selected by ARCH_EXYNOS),
>  - CHROME_PLATFORMS (selected by MFD_CROS_EC),
>  - EXT4_FS (selected by EXT3_FS)
>  - SND_SOC_ODROIDX2 (obsolete since commit ee12a817bb4b ("ASoC: samsung:
>    Remove unused Odroid x2/u3 machine driver"), replaced with
>    SND_SIMPLE_CARD).
> 
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---

Looks good to me.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
