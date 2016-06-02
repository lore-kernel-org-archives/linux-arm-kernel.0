From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 02 Jun 2016 10:47:49 +0200
Subject: [PATCH 4/4] ARM: exynos_defconfig: Save defconfig on current
 linux-next
In-Reply-To: <1464846916-3110-4-git-send-email-k.kozlowski@samsung.com>
References: <1464846916-3110-1-git-send-email-k.kozlowski@samsung.com>
 <1464846916-3110-4-git-send-email-k.kozlowski@samsung.com>
Message-ID: <574FF2B5.9070404@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/02/2016 07:55 AM, Krzysztof Kozlowski wrote:
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

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
