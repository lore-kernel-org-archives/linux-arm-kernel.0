From: afaerber@suse.de (=?ISO-8859-15?Q?Andreas_F=E4rber?=)
Date: Fri, 30 May 2014 20:19:37 +0200
Subject: [PATCH v2 Resend 1/2] ARM: EXYNOS: Update secondary boot addr
 for secure mode
In-Reply-To: <1401250382-24046-1-git-send-email-sachin.kamat@linaro.org>
References: <1401250382-24046-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <5388CBB9.1050003@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 28.05.2014 06:13, schrieb Sachin Kamat:
> Almost all Exynos-series of SoCs that run in secure mode don't need
> additional offset for every CPU, with Exynos4412 being the only
> exception.
> 
> Tested on Origen-Quad (Exynos4412) and Arndale-Octa (Exynos5420).
> 
> While at it, fix the coding style (space around *).
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
> ---
>  arch/arm/mach-exynos/firmware.c |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Fixes ODROID-XU (Exynos5410) as well - thought it had been a prereq to
applying the 5410 patches...

Tested-by: Andreas F?rber <afaerber@suse.de>

Regards,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
