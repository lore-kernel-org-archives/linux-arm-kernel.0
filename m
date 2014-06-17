From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 17 Jun 2014 18:04:08 +0200
Subject: [PATCH v4 09/11] ARM: EXYNOS: Move "mach/map.h" inclusion from
 regs-pmu.h to platsmp.c
In-Reply-To: <1399704998-13321-10-git-send-email-pankaj.dubey@samsung.com>
References: <1399704998-13321-1-git-send-email-pankaj.dubey@samsung.com>
 <1399704998-13321-10-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <53A066F8.9060702@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10.05.2014 08:56, Pankaj Dubey wrote:
> As we have removed static mappings from "regs-pmu.h" it does not
> need map.h anymore. But "platsmp.c" needed this and till now it
> got included indirectly. So lets move header inclusion of
> "mach/map.h" from "regs-pmu.h" to "platsmp.c".
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  arch/arm/mach-exynos/platsmp.c  |    1 +
>  arch/arm/mach-exynos/regs-pmu.h |    2 --
>  2 files changed, 1 insertion(+), 2 deletions(-)

This could be probably squashed with other one of previous patches, but
anyway:

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

--
Best regards,
Tomasz
