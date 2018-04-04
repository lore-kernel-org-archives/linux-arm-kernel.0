From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 4 Apr 2018 08:53:02 +0200
Subject: [PATCH v3 4/6] spi: sun6i: use completion provided by SPI core
In-Reply-To: <20180403154449.2443-5-ssuloev@orpaltech.com>
References: <20180403154449.2443-1-ssuloev@orpaltech.com>
 <20180403154449.2443-5-ssuloev@orpaltech.com>
Message-ID: <20180404065302.kq5uuybi4n4s3syr@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 03, 2018 at 06:44:47PM +0300, Sergey Suloev wrote:
> As long as the completion is already provided by the SPI core
> then there is no need to waste extra-memory on this.
> Also a waiting function was added to avoid code duplication.

This would need to be split in two patches, one to add the waiting
function, the other one to convert to the core struct completion

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180404/162a0def/attachment.sig>
