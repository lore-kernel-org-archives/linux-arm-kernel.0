From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 24 Oct 2016 10:28:02 +0200
Subject: [PATCH 1/3] phy: sun4i: check PHY id when poking unknown bit of
 pmu
In-Reply-To: <20161024035930.20274-1-icenowy@aosc.xyz>
References: <20161024035930.20274-1-icenowy@aosc.xyz>
Message-ID: <20161024082802.ev72szwmuqba5ll4@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 24, 2016 at 11:59:30AM +0800, Icenowy Zheng wrote:
> Allwinner SoC's PHY 0, when used as OTG controller, have no pmu part.
> The code that poke some unknown bit of PMU for H3/A64 didn't check
> the PHY, and will cause kernel oops when PHY 0 is used.
> 
> Fixes: b3e0d141ca9f (phy: sun4i: add support for A64 usb phy)
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Cc'ing stable would be nice.

Apart from that, Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161024/a0929938/attachment.sig>
