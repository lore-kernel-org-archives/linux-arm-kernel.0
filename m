From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 25 Aug 2016 22:31:17 +0200
Subject: [PATCH v3 4/6] clk: sunxi-ng: mux: Add clk notifier functions
In-Reply-To: <20160825062200.17206-5-wens@csie.org>
References: <20160825062200.17206-1-wens@csie.org>
 <20160825062200.17206-5-wens@csie.org>
Message-ID: <20160825203117.GE32598@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 25, 2016 at 02:21:58PM +0800, Chen-Yu Tsai wrote:
> On sunxi we support cpufreq by changing the clock rate of PLL-CPU.
> It's possible the clock output of the PLL goes out of the CPU's
> operational limits when the PLL's multipliers / dividers are changed
> and it hasn't stabilized yet. This would result in the CPU hanging.
> 
> To circumvent this, we temporarily switch the CPU mux clock to another
> stable clock before the rate change, and switch it back after the PLL
> stabilizes. This is done with clk notifiers registered on the PLL.
> 
> This patch adds common functions for notifiers to reparent mux clocks.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

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
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160825/9991d1b5/attachment.sig>
