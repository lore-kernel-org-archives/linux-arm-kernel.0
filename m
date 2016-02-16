From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 16 Feb 2016 09:47:52 +0100
Subject: [PATCH v3] clk: sunxi: Fix sun8i-a23-apb0-clk divider flags
In-Reply-To: <1455529219-30204-1-git-send-email-wens@csie.org>
References: <1455529219-30204-1-git-send-email-wens@csie.org>
Message-ID: <20160216084752.GG4344@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 05:40:19PM +0800, Chen-Yu Tsai wrote:
> The APB0 clock on A23 is a zero-based divider, not a power-of-two based
> divider.
> 
> Note that this patch does not apply cleanly to kernels before 4.5-rc1,
> which added CLK_OF_DECLARE support to this driver.
> 
> Fixes: 57a1fbf28424 ("clk: sunxi: Add A23 APB0 divider clock support")
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160216/a299ab88/attachment.sig>
