From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 25 Apr 2014 23:08:15 +0200
Subject: [PATCH v2 03/10] ARM: EXYNOS: Move SYSREG definition into sys-reg
 specific file.
In-Reply-To: <1398429166-5539-4-git-send-email-pankaj.dubey@samsung.com>
References: <1396425058-4012-1-git-send-email-pankaj.dubey@samsung.com>
 <1398429166-5539-1-git-send-email-pankaj.dubey@samsung.com>
 <1398429166-5539-4-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <535ACEBF.3090201@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pankaj,

On 25.04.2014 14:32, Pankaj Dubey wrote:
> From: Young-Gun Jang <yg1004.jang@samsung.com>
>
> While making PMU implementation to be device tree based, there are
> few register offsets related with SYSREG present in regs-pmu.h, so
> let's make a new header file "regs-sys.h" to keep all such SYSREG
> related register offsets and remove them from "regs-pmu.h"
>
> Signed-off-by: Young-Gun Jang <yg1004.jang@samsung.com>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>   arch/arm/mach-exynos/exynos.c   |    1 +
>   arch/arm/mach-exynos/pm.c       |    1 +
>   arch/arm/mach-exynos/regs-pmu.h |    3 ---
>   arch/arm/mach-exynos/regs-sys.h |   22 ++++++++++++++++++++++
>   4 files changed, 24 insertions(+), 3 deletions(-)
>   create mode 100644 arch/arm/mach-exynos/regs-sys.h

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
