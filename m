From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 17 May 2017 19:33:32 +0200
Subject: [PATCH] ARM: sun8i: v3s: enable SPI
In-Reply-To: <20170517135257.1674-1-icenowy@aosc.io>
References: <20170517135257.1674-1-icenowy@aosc.io>
Message-ID: <20170517173332.hzw7xh74hxzmbphs@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 17, 2017 at 09:52:57PM +0800, Icenowy Zheng wrote:
> Allwinner V3s SoC has a SPI controller, muxed with the MMC2 controller
> at PC bank. The controller itself is identical to the one in H3 SoC.
> 
> Add device tree node and the only pinmux node for it.
> 
> Tested with a Winbond W25Q128FV SPI NOR soldered on the Lichee Pi
> early sample.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170517/888a169a/attachment.sig>
