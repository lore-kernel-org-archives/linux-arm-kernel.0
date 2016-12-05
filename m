From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 5 Dec 2016 09:50:50 +0100
Subject: [PATCH 2/2] arm: dts: sun8i: reuse the uart1 node of iNet D978
 rev2 board
In-Reply-To: <20161202151913.38892-2-icenowy@aosc.xyz>
References: <20161202151913.38892-1-icenowy@aosc.xyz>
 <20161202151913.38892-2-icenowy@aosc.xyz>
Message-ID: <20161205085050.afgwdtbcxmpjaiwo@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 02, 2016 at 11:19:13PM +0800, Icenowy Zheng wrote:
> As a uart1 node is added into sun8i-reference-design-tablet.dtsi, simply
> use it in iNet D978 rev2 device tree.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

I'd like to see more consolidation before that change is needed. If we
find more boards using that, it will make sense, but for a single
board it's not worth it.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161205/4aa6d997/attachment.sig>
