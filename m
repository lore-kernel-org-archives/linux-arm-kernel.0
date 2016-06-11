From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 11 Jun 2016 21:47:58 +0800
Subject: [PATCH 4/4] ARM: i.MX: Move SOC_IMX1 into 'Device tree only'
In-Reply-To: <1465325585-1598-4-git-send-email-shc_work@mail.ru>
References: <1465325585-1598-1-git-send-email-shc_work@mail.ru>
 <1465325585-1598-4-git-send-email-shc_work@mail.ru>
Message-ID: <20160611134758.GP20243@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2016 at 09:53:05PM +0300, Alexander Shiyan wrote:
> This patch moves SOC_IMX1 into 'Device tree only' category and renames
> imx1-dt.c to mach-imx1.c to align with the name schema of other
> i.MX DT only platforms.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/configs/imx_v4_v5_defconfig |  8 ++-----
>  arch/arm/mach-imx/Kconfig            | 31 ++++++++++---------------
>  arch/arm/mach-imx/Makefile           |  4 +---
>  arch/arm/mach-imx/imx1-dt.c          | 45 ------------------------------------
>  arch/arm/mach-imx/mach-imx1.c        | 45 ++++++++++++++++++++++++++++++++++++

'git format-patch -M' can be used detect the renaming.

Shawn

>  5 files changed, 60 insertions(+), 73 deletions(-)
>  delete mode 100644 arch/arm/mach-imx/imx1-dt.c
>  create mode 100644 arch/arm/mach-imx/mach-imx1.c
