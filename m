From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 08 Jul 2014 16:31:55 +0200
Subject: [PATCH v6 4/4] ARM: EXYNOS: Move PMU specific definitions from
 common.h
In-Reply-To: <1404710376-16448-5-git-send-email-pankaj.dubey@samsung.com>
References: <1404710376-16448-1-git-send-email-pankaj.dubey@samsung.com>
 <1404710376-16448-5-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <53BC00DB.7020308@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07.07.2014 07:19, Pankaj Dubey wrote:
> This patch moves PMU specific definitions into a new file
> as exynos-pmu.h.
> This will help in reducing dependency of common.h in pmu.c.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  arch/arm/mach-exynos/common.h     |   17 -----------------
>  arch/arm/mach-exynos/exynos-pmu.h |   24 ++++++++++++++++++++++++
>  arch/arm/mach-exynos/pm.c         |    1 +
>  arch/arm/mach-exynos/pmu.c        |   10 +++++++++-
>  4 files changed, 34 insertions(+), 18 deletions(-)
>  create mode 100644 arch/arm/mach-exynos/exynos-pmu.h
> 

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

--
Best regards,
Tomasz
