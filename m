From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Sun, 18 Mar 2018 21:15:19 +0100
Subject: [PATCH v4 3/9] pinctrl: sunxi: change irq_bank_base to
 irq_bank_map
In-Reply-To: <20180316140215.28663-4-icenowy@aosc.io>
References: <20180316140215.28663-1-icenowy@aosc.io>
 <20180316140215.28663-4-icenowy@aosc.io>
Message-ID: <20180318201519.smbzfswz4wxdw45q@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2018 at 10:02:09PM +0800, Icenowy Zheng wrote:
> The Allwinner H6 SoC have its pin controllers with the first IRQ-capable
> GPIO bank at IRQ bank 1 and the second bank at IRQ bank 5.
> 
> Change the current code that uses IRQ bank base to a IRQ bank map, in
> order to support the case that holes exist among IRQ banks.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180318/fad1872b/attachment.sig>
