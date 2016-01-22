From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 22 Jan 2016 21:42:58 +0100
Subject: [PATCH RFC 11/15] ARM: dts: sun8i: sina33: Enable hardware reset
 and HS-DDR for eMMC
In-Reply-To: <1453354002-28366-12-git-send-email-wens@csie.org>
References: <1453354002-28366-1-git-send-email-wens@csie.org>
 <1453354002-28366-12-git-send-email-wens@csie.org>
Message-ID: <20160122204258.GD3682@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 21, 2016 at 01:26:38PM +0800, Chen-Yu Tsai wrote:
> mmc2 has a special pin for eMMC hardware reset, which is controllable
> from the controller. Add the "mmc-cap-hw-reset" property to denote that
> this controller supports this function, and the pins are actually used.
> 
> Also increase the signal drive strength for mmc2 pins, for HS-DDR mode
> support.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160122/27bb7701/attachment.sig>
