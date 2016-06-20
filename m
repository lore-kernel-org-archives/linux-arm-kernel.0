From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 20 Jun 2016 10:56:08 +0200
Subject: [PATCH v6 2/2] mtd: nand: sunxi: add reset line support
In-Reply-To: <20160620044838.56904-2-icenowy@aosc.xyz>
References: <20160620044838.56904-1-icenowy@aosc.xyz>
 <20160620044838.56904-2-icenowy@aosc.xyz>
Message-ID: <20160620085608.GK26668@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2016 at 12:48:38PM +0800, Icenowy Zheng wrote:
> The NAND controller on some sun8i chips needs its reset line to be
> deasserted before they can enter working state.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks,
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
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160620/625d192b/attachment.sig>
