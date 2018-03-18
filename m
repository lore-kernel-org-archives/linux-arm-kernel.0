From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Sun, 18 Mar 2018 21:14:47 +0100
Subject: [PATCH v4 1/9] pinctrl: sunxi: refactor irq related register
 function to have desc
In-Reply-To: <20180316140215.28663-2-icenowy@aosc.io>
References: <20180316140215.28663-1-icenowy@aosc.io>
 <20180316140215.28663-2-icenowy@aosc.io>
Message-ID: <20180318201447.grzt5yxt64s7terr@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2018 at 10:02:07PM +0800, Icenowy Zheng wrote:
> As the new H6 SoC has holes in the IRQ registers, refactor the IRQ
> related register function for getting the full pinctrl desc structure.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180318/4e93ba2f/attachment.sig>
