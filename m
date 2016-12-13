From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 13 Dec 2016 16:44:51 +0100
Subject: [PATCH 2/6] clk: sunxi-ng: set the parent rate when adjustin
 CPUX clock on A33
In-Reply-To: <20161213152252.53749-3-icenowy@aosc.xyz>
References: <20161213152252.53749-1-icenowy@aosc.xyz>
 <20161213152252.53749-3-icenowy@aosc.xyz>
Message-ID: <20161213154451.y4wcrqhtcc5sqli7@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2016 at 11:22:48PM +0800, Icenowy Zheng wrote:
> The CPUX clock on A33, which is for the Cortex-A7 cores, is designed to
> be changeable by changing the rate of PLL_CPUX.
> 
> Add CLK_SET_RATE_PARENT flag to this clock.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161213/67097aa8/attachment.sig>
