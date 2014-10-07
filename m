From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Tue, 7 Oct 2014 14:30:59 +0200
Subject: [PATCH v9 2/2] ARM: EXYNOS: Move PMU specific definitions from
 common.h
In-Reply-To: <1412587602-7763-3-git-send-email-pankaj.dubey@samsung.com>
References: <1412587602-7763-1-git-send-email-pankaj.dubey@samsung.com>
 <1412587602-7763-3-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <CABxcv=mWCDh2esb6c0Y4pLy70RUrhwZxBiarKNOoxD+gC3gLfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Pankaj,

On Mon, Oct 6, 2014 at 11:26 AM, Pankaj Dubey <pankaj.dubey@samsung.com> wrote:
> This patch moves PMU specific definitions into a new file
> as exynos-pmu.h.
> This will help in reducing dependency of common.h in pmu.c.
>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> ---
>  arch/arm/mach-exynos/common.h     |   17 -----------------
>  arch/arm/mach-exynos/exynos-pmu.h |   24 ++++++++++++++++++++++++
>  arch/arm/mach-exynos/pm.c         |    1 +
>  arch/arm/mach-exynos/pmu.c        |   20 +++++++++++++++++++-
>  arch/arm/mach-exynos/suspend.c    |    1 +
>  5 files changed, 45 insertions(+), 18 deletions(-)
>  create mode 100644 arch/arm/mach-exynos/exynos-pmu.h
>

Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
