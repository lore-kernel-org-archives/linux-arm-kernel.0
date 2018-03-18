From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Sun, 18 Mar 2018 21:15:03 +0100
Subject: [PATCH v4 2/9] pinctrl: sunxi: introduce IRQ bank conversion
 function
In-Reply-To: <20180316140215.28663-3-icenowy@aosc.io>
References: <20180316140215.28663-1-icenowy@aosc.io>
 <20180316140215.28663-3-icenowy@aosc.io>
Message-ID: <20180318201503.g3ksrwcxzjurll3m@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2018 at 10:02:08PM +0800, Icenowy Zheng wrote:
> The Allwinner H6 SoC have its pin controllers with the first IRQ-capable
> GPIO bank at IRQ bank 1 and the second bank at IRQ bank 5. Some
> refactors in the sunxi pinctrl framework are needed.
> 
> This commit introduces a IRQ bank conversion function, which replaces
> the "(bank_base + bank)" code in IRQ register access.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180318/79946eb0/attachment-0001.sig>
