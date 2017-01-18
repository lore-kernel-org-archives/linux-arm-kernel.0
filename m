From: mbenes@suse.cz (Miroslav Benes)
Date: Wed, 18 Jan 2017 13:36:52 +0100 (CET)
Subject: [PATCH 6/7] arm: Add livepatch to build if CONFIG_LIVEPATCH
In-Reply-To: <1481043967-15602-7-git-send-email-abelvesa@linux.com>
References: <1481043967-15602-1-git-send-email-abelvesa@linux.com>
 <1481043967-15602-7-git-send-email-abelvesa@linux.com>
Message-ID: <alpine.LSU.2.20.1701181336150.23458@pobox.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 6 Dec 2016, Abel Vesa wrote:

> Necessary livepatch file added to makefile.
> 
> Signed-off-by: Abel Vesa <abelvesa@linux.com>
> ---
>  arch/arm/kernel/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
> index ad325a8..9e70220 100644
> --- a/arch/arm/kernel/Makefile
> +++ b/arch/arm/kernel/Makefile
> @@ -48,6 +48,7 @@ obj-$(CONFIG_HAVE_ARM_TWD)	+= smp_twd.o
>  obj-$(CONFIG_ARM_ARCH_TIMER)	+= arch_timer.o
>  obj-$(CONFIG_FUNCTION_TRACER)	+= entry-ftrace.o
>  obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o insn.o
> +obj-$(CONFIG_LIVEPATCH)		+= livepatch.o
>  obj-$(CONFIG_FUNCTION_GRAPH_TRACER)	+= ftrace.o insn.o
>  obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o insn.o patch.o
>  obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o

This patch should not be needed as mentioned earlier.

Miroslav
