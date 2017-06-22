From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 22 Jun 2017 15:22:18 +0200
Subject: [PATCH 2/2] i2c: zx2967: add i2c controller driver for ZTE's
 zx2967 family
In-Reply-To: <20170622122558.GB23753@dragon>
References: <1495947576-11037-1-git-send-email-shawnguo@kernel.org>
 <1495947576-11037-3-git-send-email-shawnguo@kernel.org>
 <20170619193130.velebm7p3r5ggaos@ninjato>
 <20170620025815.GA4818@x250> <20170620074126.GA1541@katana>
 <20170622074831.GA23753@dragon>
 <20170622080730.o352kxrs5pz7wxnf@ninjato>
 <20170622122558.GB23753@dragon>
Message-ID: <20170622132218.GA3820@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> With the proper error handling, i2cdetect now works very fast and only
> gets audio codec on 0x22, which is correct.

Cool! Now make sure that the error codes are matching
Documentation/i2c/fault-codes and I think we are ready to go.

> Thanks a lot for identifying the bug.

You are welcome!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170622/43eccea0/attachment.sig>
