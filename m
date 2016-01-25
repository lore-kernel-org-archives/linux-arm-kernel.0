From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 25 Jan 2016 10:26:15 +0100
Subject: [PATCH] clk: sunxi: usb: Sort clk providers by chip family and
 name
In-Reply-To: <1453701300-28241-1-git-send-email-wens@csie.org>
References: <1453701300-28241-1-git-send-email-wens@csie.org>
Message-ID: <20160125092615.GJ7908@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2016 at 01:55:00PM +0800, Chen-Yu Tsai wrote:
> The latest addition of H3 USB clocks placed them at the bottom. Move it
> before A80 (sun9i), so they are sorted by SoC family then name.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160125/c47ecc2e/attachment.sig>
