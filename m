From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 2 Feb 2018 23:13:01 +0100
Subject: [PATCH 1/3] net: stmmac: dwmac-sun8i: drop V3s compatible and
 add V3 one
In-Reply-To: <20180202180456.60378-2-icenowy@aosc.io>
References: <20180202180456.60378-1-icenowy@aosc.io>
 <20180202180456.60378-2-icenowy@aosc.io>
Message-ID: <20180202221301.judzaafcu67h4c2v@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 03, 2018 at 02:04:54AM +0800, Icenowy Zheng wrote:
> The V3s is just a differently packaged version of the V3 chip, which has
> a MAC with the same capability with H3. The V3s just doesn't wire out
> the external MII/RMII/RGMII bus. (V3 wired out it).
> 
> Drop the compatible string of V3s in the dwmac-sun8i driver, and add a
> V3 compatible string, which has all capabilities.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

This breaks the DT ABI, so NAK.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180202/9492fcde/attachment.sig>
