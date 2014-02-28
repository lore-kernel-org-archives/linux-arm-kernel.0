From: tony@atomide.com (Tony Lindgren)
Date: Fri, 28 Feb 2014 14:14:39 -0800
Subject: [PATCH 0/3] OMAP hwspinlock DT updates
In-Reply-To: <1389659207-39445-1-git-send-email-s-anna@ti.com>
References: <1389659207-39445-1-git-send-email-s-anna@ti.com>
Message-ID: <20140228221439.GI13624@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Suman Anna <s-anna@ti.com> [140113 16:29]:
> Hi,
> 
> This series updates the existing OMAP hwspinlock DT nodes to have a
> #hwlock-cells property as suggested by Mark Rutland [1], and adds the
> hwspinlock nodes for two other newer SoCs - DRA7xx and AM43xx.
> 
> Posting the series separately from the driver DT adapation changes [2]
> to avoid maintainer confusion.

Thanks applying into omap-for-v3.15/dt.

Tony
 
> [1] http://marc.info/?l=linux-omap&m=138433541420926&w=2
> [2] http://marc.info/?l=linux-omap&m=138965904015225&w=2 
> 
> Suman Anna (3):
>   ARM: dts: OMAP: Add #hwlock-cells property to hwspinlock nodes
>   ARM: dts: DRA7: Add hwspinlock node
>   ARM: dts: AM4372: Add hwspinlock node
> 
>  arch/arm/boot/dts/am33xx.dtsi | 1 +
>  arch/arm/boot/dts/am4372.dtsi | 7 +++++++
>  arch/arm/boot/dts/dra7.dtsi   | 7 +++++++
>  arch/arm/boot/dts/omap4.dtsi  | 1 +
>  arch/arm/boot/dts/omap5.dtsi  | 1 +
>  5 files changed, 17 insertions(+)
> 
> -- 
> 1.8.4.3
> 
