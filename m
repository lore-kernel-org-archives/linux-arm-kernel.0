From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 10:48:14 +0100
Subject: [RFC PATCH v4 05/17] irqchip/sun4i: Add a struct to hold global
 variables
In-Reply-To: <2904a51d360af76765eccfb3b963a867a06a14ee.1543131714.git.mesihkilinc@gmail.com>
References: <cover.1543131714.git.mesihkilinc@gmail.com>
 <2904a51d360af76765eccfb3b963a867a06a14ee.1543131714.git.mesihkilinc@gmail.com>
Message-ID: <20181127094814.zxv5ovgw2xhfe5vh@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 25, 2018 at 10:43:08AM +0300, Mesih Kilinc wrote:
> In order to support different chips, IC specific data should be hold in
> a struct. This patch moves irq_base and irq_domain global variables to
> struct.
> 
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181127/766c1e30/attachment.sig>
