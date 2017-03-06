From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 6 Mar 2017 11:37:29 +0100
Subject: [PATCH v7 6/6] arm64: dts: sunxi: add support for the Orange Pi
 PC 2 board
In-Reply-To: <20170305233138.64574-7-icenowy@aosc.xyz>
References: <20170305233138.64574-1-icenowy@aosc.xyz>
 <20170305233138.64574-7-icenowy@aosc.xyz>
Message-ID: <20170306103729.y7tsj6dyydf2zmmr@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 06, 2017 at 07:31:38AM +0800, Icenowy Zheng wrote:
> From: Andre Przywara <andre.przywara@arm.com>
> 
> The Orange Pi PC 2 is a typical single board computer using the
> Allwinner H5 SoC. Apart from the usual suspects it features three
> separately driven USB ports and a Gigabit Ethernet port.
> Also it has a SPI NOR flash soldered, from which the board can boot
> from. This enables the SBC to behave like a "real computer" with
> built-in firmware.
> 
> Add the board specific .dts file, which includes the H5 .dtsi and
> enables the peripherals that we support so far.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> [Icenowy: dropped all GPIO pinctrl nodes, change red LED gpio,
>  change MMC cd to active-low, rename some node names to prevent
>  underscores]
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

And here your prefix should be "arm64: allwinner: h5:"

(This also applies to your previous patch).

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170306/8607d32a/attachment.sig>
