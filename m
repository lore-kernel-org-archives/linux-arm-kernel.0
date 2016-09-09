From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 9 Sep 2016 21:12:21 +0200
Subject: [PATCH] clk: sunxi-ng: a23: Assign base address for
 bus_spinlock_clk
In-Reply-To: <20160909035421.16119-1-wens@csie.org>
References: <20160909035421.16119-1-wens@csie.org>
Message-ID: <20160909191221.GI8881@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 09, 2016 at 11:54:21AM +0800, Chen-Yu Tsai wrote:
> bus_spinlock_clk was accidentally left out of the list of clks that
> need to be assigned the register base address.
> 
> Fixes: 8c9214b0e525 ("clk: sunxi-ng: Add A23 CCU")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

I squashed it into the A23 CCU patch.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160909/5ef50a54/attachment.sig>
