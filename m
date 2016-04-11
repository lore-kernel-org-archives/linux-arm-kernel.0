From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Mon, 11 Apr 2016 08:50:25 +0200
Subject: [PATCH] ARM: dts: imx6: Add dts for Embest MarS Board
In-Reply-To: <1460223829-13926-1-git-send-email-sergio.prado@e-labworks.com>
References: <1460223829-13926-1-git-send-email-sergio.prado@e-labworks.com>
Message-ID: <20160411085025.6fef504e@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat,  9 Apr 2016 14:43:49 -0300 Sergio Prado wrote:
> Embest MarS Board [1] is a multi-core platform based on Freescale i.MX6
> Cortex-A9 Dual Core, running up to 1GHz with 1 GB of RAM, 4GB of eMMC
> and with a 4MB SPI flash.
> 
> [1] http://www.embest-tech.com/shop/star/marsboard.html
> 
> Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
> ---
>  arch/arm/boot/dts/imx6q-marsboard.dts | 411 ++++++++++++++++++++++++++++++++++
>  1 file changed, 411 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6q-marsboard.dts
>
No Makefile entry?


Lothar Wa?mann
