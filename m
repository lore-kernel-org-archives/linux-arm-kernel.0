From: tony@atomide.com (Tony Lindgren)
Date: Thu, 26 Jan 2017 08:11:40 -0800
Subject: [PATCH v2 1/3] ARM: dts: Add support for phyCORE-AM335x PCM-953
 carrier board
In-Reply-To: <1485252576-36955-1-git-send-email-t.remmet@phytec.de>
References: <1485252576-36955-1-git-send-email-t.remmet@phytec.de>
Message-ID: <20170126161140.GR7403@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Teresa Remmet <t.remmet@phytec.de> [170124 02:10]:
> The phyCORE-AM335x development kit is a combination of the
> phyCORE-AM335x SoM and a PCM-953 carrier board. The features
> of the PCM-953 are:
> * ETH phy on carrier board: 1x RGMII
> * 1x CAN
> * Up to 4x UART
> * USB0 (otg)
> * USB1 (host)
> * SD slot
> * User gpio-keys
> * User LEDs
> 
> Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
> Reviewed-by: Wadim Egorov <w.egorov@phytec.de>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> Changes in v2:
> - moved gpio-keys, gpio-leds and regulators nodes to root node
> - moved muxing of gpio-keys and gpio-leds
> - removed not needed compatible "simple-bus"
> - fixed unit address of ethernet phy node
> - removed redundant status properties
> - added Acked-by: Rob Herring <robh@kernel.org>

Applying this into omap-for-v4.11/dt thanks. The defconfig changes
I already applied into omap-for-v4.11/defconfig.

Regards,

Tony
