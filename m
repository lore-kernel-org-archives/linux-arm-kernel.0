From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 12 Nov 2018 21:23:01 +0100
Subject: [PATCH] ARM: EXYNOS: remove no longer needed s3c_pm_check_*()
 calls
In-Reply-To: <20181015134828eucas1p1b0b3287b5a330591e0976a3a83edbf11~dzFPt-ZL_1531815318eucas1p1t@eucas1p1.samsung.com>
References: <CGME20181015134828eucas1p1b0b3287b5a330591e0976a3a83edbf11@eucas1p1.samsung.com>
 <20181015134828eucas1p1b0b3287b5a330591e0976a3a83edbf11~dzFPt-ZL_1531815318eucas1p1t@eucas1p1.samsung.com>
Message-ID: <20181112202301.GA25275@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 15, 2018 at 03:48:27PM +0200, Bartlomiej Zolnierkiewicz wrote:
> Since commit 6862fdf2201a ("ARM: samsung: Limit SAMSUNG_PM_CHECK
> config option to non-Exynos platforms") s3c_pm_check_*() calls
> are redundant and can be removed.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm/mach-exynos/suspend.c |    7 -------

Thanks, applied.

Best regards,
Krzysztof
