From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 22 Jan 2012 13:08:26 -0200
Subject: [PATCH] ARM: imx: iomux-v1.h: Fix build error due to __init
 annotation
In-Reply-To: <1325799188-24921-1-git-send-email-festevam@gmail.com>
References: <1325799188-24921-1-git-send-email-festevam@gmail.com>
Message-ID: <CAOMZO5B=qW1k3Rk2Eip3RJfaWu4j1O5DiPhs0htUFutnSisvmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Thu, Jan 5, 2012 at 7:33 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Fix the following build error found when building imx_v4_v5_defconfig:
>
> ?CC ? ? ?arch/arm/mach-imx/mach-imx27ipcam.o
> In file included from arch/arm/plat-mxc/include/mach/iomux-mx27.h:23,
> ? ? ? ? ? ? ? ? from arch/arm/mach-imx/mach-imx27ipcam.c:22:
> arch/arm/plat-mxc/include/mach/iomux-v1.h:99: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'imx_iomuxv1_init'
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> This applies against linux-next

This is still broken in linux next. Is this patch OK?

Regards,

Fabio Estevam
