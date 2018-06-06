From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 6 Jun 2018 21:37:01 +0200
Subject: [PATCH v2 3/3] arm64: dts: allwinner: add support for Pinebook
In-Reply-To: <20180606051702.6478-4-anarsoul@gmail.com>
References: <20180606051702.6478-1-anarsoul@gmail.com>
 <20180606051702.6478-4-anarsoul@gmail.com>
Message-ID: <20180606193701.seerxyy6g3nx3flk@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 05, 2018 at 10:17:02PM -0700, Vasily Khoruzhick wrote:
> From: Icenowy Zheng <icenowy@aosc.xyz>
> 
> Pinebook is a A64-based laptop produced by Pine64, with the following
> peripherals:
> 
> USB:
> - Two external USB ports (one is directly connected to A64's OTG
> controller, the other is under a internal hub connected to the host-only
> controller.)
> - USB HID keyboard and touchpad connected to the internal hub.
> - USB UVC camera connected to the internal hub.
> 
> Power-related:
> - A DC IN jack connected to AXP803's DCIN pin.
> - A Li-Polymer battery connected to AXP803's battery pins.
> 
> Storage:
> - An eMMC by Foresee on the main board (in the product revision of the
> main board it's designed to be switchable).
> - An external MicroSD card slot.
> 
> Display:
> - An eDP LCD panel (1366x768) connected via an ANX6345 RGB-eDP bridge.
> - A mini HDMI port.
> 
> Misc:
> - A Hall sensor designed to detect the status of lid, connected to GPIO PL12.
> - A headphone jack connected to the SoC's internal codec.
> - A debug UART port muxed with headphone jack.
> 
> This commit adds basical support for it.
> 
> [vasily: squashed several commits into one, added simplefb node, added usbphy
> 	 to ehci0 and ohci0 nodes and other cosmetic changes to dts]
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

I've updated Icenowy's domain and applied, thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
