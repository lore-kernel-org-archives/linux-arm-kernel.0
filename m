From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sun, 10 Jul 2016 21:45:46 +0100
Subject: [PATCH] ARM: dts: armada-388-clearfog: remove duplicate mdio entry
In-Reply-To: <20160710203751.GB26397@lunn.ch>
References: <E1bMGdu-00005c-Dy@rmk-PC.armlinux.org.uk>
 <20160710203751.GB26397@lunn.ch>
Message-ID: <20160710204546.GS1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 10, 2016 at 10:37:51PM +0200, Andrew Lunn wrote:
> The armada-38x.dtsi has
> 
>                                 ref_clk0_pins: ref-clk-pins-0 {
>                                         marvell,pins = "mpp45";
>                                         marvell,function = "ref";
>                                 };
> 
> which you could reference rather then defining it yourself.

Weren't these going to be deleted from the main SoC dtsi files,
eventually?  I thought that was the idea, to prevent cluttering
up the .dtb files with nodes which aren't ever used.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
