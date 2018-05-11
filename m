From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 11 May 2018 10:37:44 +0200
Subject: [PATCH 1/2] arm64: dts: allwinner: a64: Update Orange Pi Win/Win
 Plus
In-Reply-To: <20180511030124.9356-1-samuel@sholland.org>
References: <20180511030124.9356-1-samuel@sholland.org>
Message-ID: <20180511083744.jpzt7m3vbk5epqjj@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Samuel,

On Thu, May 10, 2018 at 10:01:23PM -0500, Samuel Holland wrote:
> Enable the following board hardware features:
> - Gigabit Ethernet
> - SDIO Wi-Fi on mmc1
> - SPI flash on spi0
> - Status LED
> - Dual-role micro-USB connection
> 
> Also provide nodes for the UARTs exposed by the 40-pin GPIO header.
> 
> A couple of fixes were made:
> - Updating a couple of regulators from the schematic
> - Marking the CPU's power supply as such

All these changes look sane, but you should really split them into
more patches to have one of these changes per patch. We really don't
mind having more patches when it's justified, and this is definitely
the case for both your patches.

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180511/852a4711/attachment.sig>
