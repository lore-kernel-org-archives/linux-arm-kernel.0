From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 27 Mar 2012 11:14:25 +0200
Subject: [MX25][MMC] mmc esdhc failure in 3.3
In-Reply-To: <20120327110615.3bfaf969@eb-e6520>
References: <5e57eb999780335721212bb8d411406f@mail.fqingenieria.es>
 <20120312132423.GC2459@pengutronix.de>
 <9018463dfcd3c9e9a311aeed42b758bf@mail.fqingenieria.es>
 <0E83723C55F66F43A6041464FE31119D099A34@039-SN2MPN1-011.039d.mgd.msft.net>
 <a06e68c3687c7390e15950bc20831fd4@mail.fqingenieria.es>
 <85b807b77d73328485781d6fa1568e46@mail.fqingenieria.es>
 <20120327101259.73525f9d@eb-e6520>
 <ac05d6e5c1ce4bf9cfc5c28d235f866f@mail.fqingenieria.es>
 <20120327090148.GB6790@pengutronix.de>
 <20120327110615.3bfaf969@eb-e6520>
Message-ID: <20120327091425.GC6790@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > Interesting question is now why it worked on your older kernel? The code
> > around BROKEN_TIMEOUT is there for much longer, I'd think.
> > 
> not in fact it seems to have been broken from a long time and I think

I know and you are saying the same, in fact :) Your patch came in around
2.6.37 and here it was said that 2.6.39 works fine. Might be random,
though.

> because unlike the i.MX35 it seems that the i.MX25 manages to read
> properly the partition table even without the timeout quirk and it
> seems that I didn't do more extensive tests for this patch.

Please do next time.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120327/10d98581/attachment.sig>
