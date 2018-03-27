From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Mar 2018 09:49:00 +0200
Subject: sun6i spi driver issue
In-Reply-To: <16d32ee2-886a-a169-a1a8-f05ee6a09a66@orpaltech.com>
References: <16d32ee2-886a-a169-a1a8-f05ee6a09a66@orpaltech.com>
Message-ID: <20180327074900.q57t3w2disku53eo@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 24, 2018 at 09:42:24AM +0300, Sergey Suloev wrote:
> the following patch [1] isn't working on my BPi M2, OPi PC, OPi PC+. I have
> no more boards to test currently but I am sure it will fail on others too.
> As soon as the max transfer size is set to a value MORE THAN FIFO then most
> of transfers would end up with -110 (timeout).
> 
> [1] https://patchwork.kernel.org/patch/9634315/

Is that related to your other discussion? Why did you drop most of the
recipients from that thread, including the SPI maintainer and the SPI
ML?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180327/15a6ee24/attachment.sig>
