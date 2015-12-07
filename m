From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 7 Dec 2015 09:58:56 +0100
Subject: [PATCH resend 1/6] clk: sunxi: Add DRAM gates support for
 sun4i-a10
In-Reply-To: <1449321407-4531-2-git-send-email-wens@csie.org>
References: <1449321407-4531-1-git-send-email-wens@csie.org>
 <1449321407-4531-2-git-send-email-wens@csie.org>
Message-ID: <20151207085856.GA27957@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 05, 2015 at 09:16:42PM +0800, Chen-Yu Tsai wrote:
> The A10/A20 share the same set of DRAM clock gates, which controls
> direct memory access for some peripherals.
> 
> On the A10, bit 15 controls the system's DRAM clock output (possibly
> to the DRAM chips), which we need to keep on.
> 
> On the A20 this has been moved to the DRAM controller, becoming a no-op.
> However it is still listed in the user manual, so add it anyway.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151207/87297f43/attachment.sig>
