From: davem@davemloft.net (David Miller)
Date: Wed, 09 Nov 2016 12:51:24 -0500 (EST)
Subject: [PATCH net-next 0/2] ARM64: Add Internal PHY support for Meson GXL
In-Reply-To: <1478274683-1503-1-git-send-email-narmstrong@baylibre.com>
References: <1478274683-1503-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <20161109.125124.589689108919427759.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Neil Armstrong <narmstrong@baylibre.com>
Date: Fri,  4 Nov 2016 16:51:21 +0100

> The Amlogic Meson GXL SoCs have an internal RMII PHY that is muxed with the
> external RGMII pins.
> 
> In order to support switching between the two PHYs links, extended registers
> size for mdio-mux-mmioreg must be added.
> 
> The DT related patches submitted as RFC in [3] will be sent in a separate
> patchset due to multiple patchsets and DTSI migrations.
> 
> Changes since v2 RFC patchset at : [3]
>  - Change phy Kconfig/Makefile alphabetic order
>  - GXL dtsi cleanup
> 
> Changes since original RFC patchset at : [2]
>  - Remove meson8b experimental phy switching
>  - Switch to mdio-mux-mmioreg with extennded size support
>  - Add internal phy support for S905x and p231
>  - Add external PHY support for p230
> 
> [1] http://lkml.kernel.org/r/1477932286-27482-1-git-send-email-narmstrong at baylibre.com
> [2] http://lkml.kernel.org/r/1477060838-14164-1-git-send-email-narmstrong at baylibre.com
> [3] http://lkml.kernel.org/r/1477932987-27871-1-git-send-email-narmstrong at baylibre.com

Series applied, thanks.
