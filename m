From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 15 Jan 2018 18:19:00 +0100
Subject: [PATCH v3 2/2] i2c: mv64xxx: Fix clock resource by adding an
 optional bus clock
In-Reply-To: <87wp0n5nw1.fsf@free-electrons.com>
References: <20180112103956.4875-1-gregory.clement@free-electrons.com>
 <20180112103956.4875-3-gregory.clement@free-electrons.com>
 <20180112105434.juefp2apuber3zti@flea.lan>
 <87wp0n5nw1.fsf@free-electrons.com>
Message-ID: <20180115171859.nukvtrez5yun4564@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > Are you sure the i2c controller is on the AXI bus? It seems more
> > likely to be on an APB bus.
> 
> No I am not sure :)
> Actually I don't have this information, so lets call it "reg" for
> register clock.

So, I assume a V4 is needed for this series.

BTW would be someone from FreeElectrons be up to maintaining this
driver?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180115/50eaf8f1/attachment.sig>
