From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 30 Jun 2014 18:20:34 +0200
Subject: [PATCH v5 3/5] ARM: EXYNOS: Move "mach/map.h" inclusion from
 regs-pmu.h to platsmp.c
In-Reply-To: <1403705032-14835-4-git-send-email-pankaj.dubey@samsung.com>
References: <1403705032-14835-1-git-send-email-pankaj.dubey@samsung.com>
 <1403705032-14835-4-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <53B18E52.1060906@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pankaj,

On 25.06.2014 16:03, Pankaj Dubey wrote:
> As we have removed static mappings from "regs-pmu.h" it does not
> need map.h anymore. But "platsmp.c" needed this and till now it
> got included indirectly. So lets move header inclusion of
> "mach/map.h" from "regs-pmu.h" to "platsmp.c".
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> ---
>  arch/arm/mach-exynos/platsmp.c  |    2 ++
>  arch/arm/mach-exynos/regs-pmu.h |    2 --
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

IMHO this could be squashed with previous patch.

Best regards,
Tomasz
