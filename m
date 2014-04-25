From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 25 Apr 2014 23:14:01 +0200
Subject: [PATCH v2 04/10] ARM: EXYNOS: Remove file path from comment
 section
In-Reply-To: <1398429166-5539-5-git-send-email-pankaj.dubey@samsung.com>
References: <1396425058-4012-1-git-send-email-pankaj.dubey@samsung.com>
 <1398429166-5539-1-git-send-email-pankaj.dubey@samsung.com>
 <1398429166-5539-5-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <535AD019.8050207@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pankaj,

On 25.04.2014 14:32, Pankaj Dubey wrote:
> Many files under "arm/mach-exynos" are having file path in file
> comment section which is invalid now.
> So for better code maintainability let's remove them.
>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>   arch/arm/mach-exynos/headsmp.S             |    2 --
>   arch/arm/mach-exynos/hotplug.c             |    3 +--
>   arch/arm/mach-exynos/include/mach/memory.h |    3 +--
>   arch/arm/mach-exynos/platsmp.c             |    3 +--
>   4 files changed, 3 insertions(+), 8 deletions(-)

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
