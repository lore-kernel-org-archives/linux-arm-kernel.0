From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Tue, 11 Nov 2014 10:44:45 +0100
Subject: [PATCH] ARM: EXYNOS: fix typo in static struct name
 "exynos5_list_diable_wfi_wfe"
In-Reply-To: <1414489832-28011-1-git-send-email-pankaj.dubey@samsung.com>
References: <1414489832-28011-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <CABxcv=nJ7-NoF-0EqCL=rk6hX2688iV98g=CiDADKT7QTNWBrw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Pankaj, Kukjin,

On Tue, Oct 28, 2014 at 10:50 AM, Pankaj Dubey <pankaj.dubey@samsung.com> wrote:
> This patch fixes a typo in struct named as "exynos5_list_diable_wfi_wfe"
> by making it "exynos5_list_disable_wfi_wfe" which is more meaningful.
>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>

After this patch, "[PATCH v9 1/2] ARM: EXYNOS: Add platform driver
support for Exynos PMU" [0] does not apply cleanly anymore.

Pankaj,

Are you planning to rebase and re-post that patch?

Kukjin,

It would be great if you can pick all the pending Exynos5420 S2R
patches to avoid these kind of conflicts.

Thanks a lot and best regards,
Javier

[0]: https://lkml.org/lkml/2014/10/6/90
