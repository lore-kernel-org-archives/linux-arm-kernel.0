From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 9 Nov 2011 17:56:35 +0000
Subject: [PATCH v2] ARM: arch.h: Declare 'pt_regs' locally
In-Reply-To: <1320840648-3197-1-git-send-email-fabio.estevam@freescale.com>
References: <1320840648-3197-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20111109175635.GO12913@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 09, 2011 at 10:10:48AM -0200, Fabio Estevam wrote:
> Fix the following warning when building imx_v4_v5_defconfig target:
> 
>   CC      arch/arm/mach-imx/mach-imx27ipcam.o
> In file included from arch/arm/mach-imx/mach-imx27ipcam.c:18:
> /home/fabio/linus/linux-2.6/arch/arm/include/asm/mach/arch.h:47: warning: 'struct pt_regs' declared inside parameter list
> /home/fabio/linus/linux-2.6/arch/arm/include/asm/mach/arch.h:47: warning: its scope is only this definition or declaration, which is probably not what you want
> arch/arm/mach-imx/mach-imx27ipcam.c:78: warning: initialization from incompatible pointer type
> 
> Declare 'struct pt_regs' locally.
> 
> Cc: Eric Miao <eric.miao@canonical.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Yup.  Can go to the patch system, thanks.
