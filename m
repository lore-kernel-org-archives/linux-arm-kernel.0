From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 24 Jan 2016 17:58:57 +0100
Subject: [PATCH RFC 13/15] ARM: dts: sun9i: Include SDC2_RST pin in
 mmc2_8bit_pins
In-Reply-To: <1453354002-28366-14-git-send-email-wens@csie.org>
References: <1453354002-28366-1-git-send-email-wens@csie.org>
 <1453354002-28366-14-git-send-email-wens@csie.org>
Message-ID: <20160124165857.GD7908@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 21, 2016 at 01:26:40PM +0800, Chen-Yu Tsai wrote:
> mmc2_8bit_pins is used with eMMC chips, which also have a reset pin.
> The MMC controller also has a reset output that is supported.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160124/09b2f659/attachment.sig>
