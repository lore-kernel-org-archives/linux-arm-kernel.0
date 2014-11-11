From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Tue, 11 Nov 2014 10:54:30 +0100
Subject: [PATCH] ARM: EXYNOS: fix typo in static struct name
 "exynos5_list_diable_wfi_wfe"
In-Reply-To: <CABxcv=nJ7-NoF-0EqCL=rk6hX2688iV98g=CiDADKT7QTNWBrw@mail.gmail.com>
References: <1414489832-28011-1-git-send-email-pankaj.dubey@samsung.com>
 <CABxcv=nJ7-NoF-0EqCL=rk6hX2688iV98g=CiDADKT7QTNWBrw@mail.gmail.com>
Message-ID: <CABxcv==Hjfi+-Mt63YQaCtC3Wj12WFfU6biwmiVEFQvqAp3DBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Kukjin,

>
> After this patch, "[PATCH v9 1/2] ARM: EXYNOS: Add platform driver
> support for Exynos PMU" [0] does not apply cleanly anymore.
>

I see that you already picked all the Exynos S2R patches on your
v3.19-next/mach-exynos branch and also resolved that conflict.

Is just that this branch was not merged in your for-next branch and
that's why I didn't see the patches in linux-next.

Sorry for the noise.

Best regards,
Javier
