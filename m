From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 12 Jul 2013 16:15:40 +0100
Subject: [PATCH] ARM: Kconfig: Let ARM_ERRATA_364296 not depend on
 CONFIG_SMP
In-Reply-To: <1373319489-9467-1-git-send-email-festevam@gmail.com>
References: <1373319489-9467-1-git-send-email-festevam@gmail.com>
Message-ID: <20130712151540.GG28271@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 08, 2013 at 10:38:09PM +0100, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> imx_v6_v7_defconfig handles both multi-core and single-core SoCs, and it has 
> CONFIG_SMP=y selected by default.
> 
> With such config we cannot select ARM_ERRATA_364296, as it depends on !SMP.
> 
> Let ARM_ERRATA_364296 be undependent on CONFIG_SMP, so that we can select
> this erratum for the ARM1136 SoCs, even if CONFIG_SMP=y is enabled.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

I've just seen the patch (long email backlog).

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
