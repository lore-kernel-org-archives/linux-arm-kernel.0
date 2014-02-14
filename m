From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 14 Feb 2014 19:58:33 +0100
Subject: [PATCH v3 1/3] ARM: EXYNOS: initial board support for exynos5260
 SoC
In-Reply-To: <1392385032-22015-2-git-send-email-rahul.sharma@samsung.com>
References: <1392385032-22015-1-git-send-email-rahul.sharma@samsung.com>
 <1392385032-22015-2-git-send-email-rahul.sharma@samsung.com>
Message-ID: <52FE6759.1040006@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 14.02.2014 14:37, Rahul Sharma wrote:
> From: Pankaj Dubey <pankaj.dubey@samsung.com>
>
> This patch add basic arch side support for exynos5260 SoC.
>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Arun Kumar K <arun.kk@samsung.com>
> Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
> ---
>   arch/arm/mach-exynos/Kconfig             |    9 +++++++++
>   arch/arm/mach-exynos/common.c            |   11 +++++++++++
>   arch/arm/mach-exynos/include/mach/map.h  |    1 +
>   arch/arm/mach-exynos/mach-exynos5-dt.c   |    1 +
>   arch/arm/plat-samsung/include/plat/cpu.h |    8 ++++++++
>   5 files changed, 30 insertions(+)

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
