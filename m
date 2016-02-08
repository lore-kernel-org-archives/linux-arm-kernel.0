From: tony@atomide.com (Tony Lindgren)
Date: Mon, 8 Feb 2016 12:03:24 -0800
Subject: [PATCH] ARM: drop unused Makefile.boot of Multiplatform SoCs
In-Reply-To: <56B4E2B0.8060808@xilinx.com>
References: <1454693808-13081-1-git-send-email-yamada.masahiro@socionext.com>
 <56B4E2B0.8060808@xilinx.com>
Message-ID: <20160208200324.GY19432@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Michal Simek <michal.simek@xilinx.com> [160205 09:59]:
> On 5.2.2016 18:36, Masahiro Yamada wrote:
> > The variable "MACHINE" is empty if CONFIG_ARCH_MULTIPLATFORM=y,
> > so these Makefile.boot files are never included.
> > 
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> > 
> >  arch/arm/mach-cns3xxx/Makefile.boot    | 3 ---
> >  arch/arm/mach-exynos/Makefile.boot     | 2 --
> >  arch/arm/mach-integrator/Makefile.boot | 4 ----
> >  arch/arm/mach-keystone/Makefile.boot   | 1 -
> >  arch/arm/mach-mmp/Makefile.boot        | 1 -
> >  arch/arm/mach-mv78xx0/Makefile.boot    | 3 ---
> >  arch/arm/mach-nspire/Makefile.boot     | 0
> >  arch/arm/mach-omap2/Makefile.boot      | 3 ---
> >  arch/arm/mach-orion5x/Makefile.boot    | 3 ---
> >  arch/arm/mach-prima2/Makefile.boot     | 3 ---
> >  arch/arm/mach-realview/Makefile.boot   | 9 ---------
> >  arch/arm/mach-s3c64xx/Makefile.boot    | 2 --
> >  arch/arm/mach-spear/Makefile.boot      | 3 ---
> >  arch/arm/mach-u300/Makefile.boot       | 4 ----
> >  arch/arm/mach-ux500/Makefile.boot      | 3 ---
> >  arch/arm/mach-zynq/Makefile.boot       | 3 ---
> 
> Acked-by: Michal Simek <michal.simek@xilinx.com> (for Zynq)

I doubt anybody wants to go back to disabling MULTIPLATFORM:

Acked-by: Tony Lindgren <tony@atomide.com>
