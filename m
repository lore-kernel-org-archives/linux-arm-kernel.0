From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 13 Dec 2016 16:44:26 +0100
Subject: [PATCH 1/6] clk: sunxi-ng: fix PLL_CPUX adjusting on A33
In-Reply-To: <20161213152252.53749-2-icenowy@aosc.xyz>
References: <20161213152252.53749-1-icenowy@aosc.xyz>
 <20161213152252.53749-2-icenowy@aosc.xyz>
Message-ID: <20161213154426.gnuohez6seeu7kso@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2016 at 11:22:47PM +0800, Icenowy Zheng wrote:
> When adjusting PLL_CPUX on A33, the PLL is temporarily driven too high,
> and the system hangs.
> 
> Add a notifier to avoid this situation by temporarily switching to a
> known stable 24 MHz oscillator.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161213/583d3807/attachment.sig>
