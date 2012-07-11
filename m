From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 11 Jul 2012 12:16:14 +0800
Subject: [PATCH 0/6] Improve apx4devkit DT support
In-Reply-To: <1341904092-13777-1-git-send-email-lauri.hintsala@bluegiga.com>
References: <1341904092-13777-1-git-send-email-lauri.hintsala@bluegiga.com>
Message-ID: <20120711041612.GD14060@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2012 at 10:08:06AM +0300, Lauri Hintsala wrote:
> Add NAND, display and SSP2 support for apx4devkit.
> 
> Patches are based on Shawn's mxs/dt/others-v2 branch.
> 
> Lauri
> 
> ---
> Lauri Hintsala (6):
>   ARM: apx4devkit: add NAND support
>   ARM: apx4devkit: add display support
>   ARM: apx4devkit: fix the bus-width of SSP0 to 4 bits
>   ARM: apx4devkit: add SSP2 support
>   ARM: apx4devkit: remove AUART3
>   ARM: apx4devkit: add pin muxing for GPIOs

All applied, thanks.

Regards,
Shawn

> 
>  arch/arm/boot/dts/apx4devkit.dts |   75 +++++++++++++++++++++++++++++++++-----
>  arch/arm/mach-mxs/mach-mxs.c     |   24 ++++++++++++
>  2 files changed, 89 insertions(+), 10 deletions(-)
> 
> -- 
> 1.7.9.5
> 
