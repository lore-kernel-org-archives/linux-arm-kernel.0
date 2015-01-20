From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 20 Jan 2015 17:04:13 +0100
Subject: [PATCH v5] clk: sunxi: Add driver for A80 MMC config clocks/resets
In-Reply-To: <1421768791-20170-1-git-send-email-wens@csie.org>
References: <1421768791-20170-1-git-send-email-wens@csie.org>
Message-ID: <20150120160413.GU4367@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 20, 2015 at 11:46:31PM +0800, Chen-Yu Tsai wrote:
> On the A80 SoC, the 4 mmc controllers each have a separate register
> controlling their register access clocks and reset controls. These
> registers in turn share a ahb clock gate and reset control.
> 
> This patch adds a platform device driver for these controls. It
> requires both clocks and reset controls to be available, so using
> CLK_OF_DECLARE might not be the best way.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Merged, thanks!

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150120/8cf39ef9/attachment.sig>
