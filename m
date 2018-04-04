From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 4 Apr 2018 09:13:26 +0200
Subject: [PATCH v2 4/6] spi: sun4i: use completion provided by SPI core
 driver
In-Reply-To: <20180403152905.1524-5-ssuloev@orpaltech.com>
References: <20180403152905.1524-1-ssuloev@orpaltech.com>
 <20180403152905.1524-5-ssuloev@orpaltech.com>
Message-ID: <20180404071326.6mcaal77mzgfnhuy@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 03, 2018 at 06:29:03PM +0300, Sergey Suloev wrote:
> As long as the completion already provided by the SPI core
> then there is no need to waste extra-memory on this.
> Also a waiting function was added to avoid code duplication.

This should also be split in two parts.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180404/d615ec4b/attachment.sig>
