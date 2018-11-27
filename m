From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 10:49:06 +0100
Subject: [RFC PATCH v4 06/17] irqchip/sun4i: Move IC specific register
 offsets to struct
In-Reply-To: <0242923026be282e26fe9e50d9bb0ec3d5ae355f.1543131714.git.mesihkilinc@gmail.com>
References: <cover.1543131714.git.mesihkilinc@gmail.com>
 <0242923026be282e26fe9e50d9bb0ec3d5ae355f.1543131714.git.mesihkilinc@gmail.com>
Message-ID: <20181127094906.l7mebisuoikrivf2@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 25, 2018 at 10:43:09AM +0300, Mesih Kilinc wrote:
> This patch moves IC specific register offsets to sun4i_irq_chip_data
> struct in order to support different chips.
> 
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181127/1727ee3d/attachment.sig>
