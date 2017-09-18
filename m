From: horms@verge.net.au (Simon Horman)
Date: Mon, 18 Sep 2017 10:13:38 +0200
Subject: [PATCH v2 7/8] arm64: dts: renesas: initial Eagle board device
 tree
In-Reply-To: <20170915194445.950496886@cogentembedded.com>
References: <20170915194445.950496886@cogentembedded.com>
Message-ID: <20170918081338.GD4644@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 15, 2017 at 10:43:25PM +0300, Sergei Shtylyov wrote:
> Add the initial device  tree for  the R8A77970 SoC based Eagle board.
> The board has 1 debug serial port (SCIF0); include support for it,
> so that the serial console can work.
> 
> Based on the original (and large) patch by Vladimir Barinov
> <vladimir.barinov@cogentembedded.com>.
> 
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
>  arch/arm64/boot/dts/renesas/Makefile           |    1 
>  arch/arm64/boot/dts/renesas/r8a77970-eagle.dts |   45 +++++++++++++++++++++++++
>  2 files changed, 46 insertions(+)
> 
> Index: renesas/arch/arm64/boot/dts/renesas/Makefile
> ===================================================================
> --- renesas.orig/arch/arm64/boot/dts/renesas/Makefile
> +++ renesas/arch/arm64/boot/dts/renesas/Makefile
> @@ -2,6 +2,7 @@ dtb-$(CONFIG_ARCH_R8A7795) += r8a7795-sa
>  dtb-$(CONFIG_ARCH_R8A7795) += r8a7795-salvator-xs.dtb
>  dtb-$(CONFIG_ARCH_R8A7795) += r8a7795-es1-salvator-x.dtb r8a7795-es1-h3ulcb.dtb
>  dtb-$(CONFIG_ARCH_R8A7796) += r8a7796-salvator-x.dtb r8a7796-m3ulcb.dtb
> +dtb-$(CONFIG_ARCH_R8A77970) += r8a77970-eagle.dtb
>  dtb-$(CONFIG_ARCH_R8A77995) += r8a77995-draak.dtb

Please consider submitting a patch to enable CONFIG_ARCH_R8A77970
in the ARM64 defconfig.
