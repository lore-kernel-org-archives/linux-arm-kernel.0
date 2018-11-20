From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 20 Nov 2018 08:58:03 +0100
Subject: [PATCH 0/3] arm64: dts: allwinner: h6: orangepi: Enable USB 2.0
 and LEDs
In-Reply-To: <20181120065311.30009-1-wens@csie.org>
References: <20181120065311.30009-1-wens@csie.org>
Message-ID: <20181120075803.6735awl2zd5ak2fo@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2018 at 02:53:08PM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> This small series enables USB 2.0 and LEDs on the Orange Pi Lite 2 and
> Orange Pi One Plus. The two features are unrelated, but included in the
> same series as the patch contexts overlap.
> 
> Patch one adds a fixed regulator to represent the board-wide 5V rail.
> While not strictly necessary, this helps define the relationship between
> regulators.
> 
> Patch two enables USB 2.0 host and OTG. Note that VBUS on both ports are
> directly tied to the 5V rail, without any power switches or current
> limiters.
> 
> Patch three add device nodes for the two LEDs. These LEDs are driven
> directly by the GPIO pins, without a current limiting resistor. At the
> default drive strength, the LEDs are quite bright.

Applied all three patches, thanks!

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181120/d04bb042/attachment-0001.sig>
