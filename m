From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Mon, 17 Jun 2013 10:02:19 +0200
Subject: [PATCH v3 0/4] Zynq: Support more boards
In-Reply-To: <1371141438-16553-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1371141438-16553-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <20130617080219.GA2062@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 13, 2013 at 09:37:14AM -0700, Soren Brinkmann wrote:
> Just another respin. Still depending on armsoc/zynq/clk
> 
> 	S?ren
> 
> v3:
>  - adding patch to use 'status' property for UART nodes
>  - dropping board specific compat string in the Zed dts
> 
> v2:
>  - adding patch to remove board specific compat strings from the BSP
>  - adding patch adding Zed support
> 
> Soren Brinkmann (4):
>   arm: zynq: Remove board specific compatibility string
>   arm: dt: zynq: Use 'status' property for UART nodes
>   arm: dt: zynq: Add support for the zc706 platform
>   arm: dt: zynq: Add support for the zed platform
> 
>  arch/arm/boot/dts/Makefile       |  4 +++-
>  arch/arm/boot/dts/zynq-7000.dtsi |  2 ++
>  arch/arm/boot/dts/zynq-zc702.dts |  6 +++++-
>  arch/arm/boot/dts/zynq-zc706.dts | 35 +++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/zynq-zed.dts   | 35 +++++++++++++++++++++++++++++++++++
>  arch/arm/mach-zynq/common.c      |  1 -
>  6 files changed, 80 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm/boot/dts/zynq-zc706.dts
>  create mode 100644 arch/arm/boot/dts/zynq-zed.dts
> 
> -- 
> 1.8.3
> 
> 

Hi!

The series looks okay now:

	Reviewed-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>

Regards,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
