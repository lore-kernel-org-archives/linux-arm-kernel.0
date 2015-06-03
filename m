From: tony@atomide.com (Tony Lindgren)
Date: Wed, 3 Jun 2015 08:43:10 -0700
Subject: [PATCHv4 08/10] arm/dts: dra7.dtsi: add DSS support
In-Reply-To: <1433139798-23450-9-git-send-email-tomi.valkeinen@ti.com>
References: <1433139798-23450-1-git-send-email-tomi.valkeinen@ti.com>
 <1433139798-23450-9-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <20150603154309.GQ30984@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [150531 23:25]:
> DRA7xxx contains a very similar DSS to OMAP5. The main differences are:
> 
> * no DSI or RFBI support.
> * 1 or 2 dedicated video PLLs.
> * need to do additional configuration to the DRA7 CONTROL module.
> 
> DRA72xx has only one video PLL, and DRA74xx has two.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: devicetree at vger.kernel.org

Acked-by: Tony Lindgren <tonY@atomide.com>
