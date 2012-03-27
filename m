From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 27 Mar 2012 11:36:44 +0200
Subject: [MX25][MMC] mmc esdhc failure in 3.3
In-Reply-To: <20120327112342.73a85a1b@eb-e6520>
References: <9018463dfcd3c9e9a311aeed42b758bf@mail.fqingenieria.es>
 <0E83723C55F66F43A6041464FE31119D099A34@039-SN2MPN1-011.039d.mgd.msft.net>
 <a06e68c3687c7390e15950bc20831fd4@mail.fqingenieria.es>
 <85b807b77d73328485781d6fa1568e46@mail.fqingenieria.es>
 <20120327101259.73525f9d@eb-e6520>
 <ac05d6e5c1ce4bf9cfc5c28d235f866f@mail.fqingenieria.es>
 <20120327090148.GB6790@pengutronix.de>
 <20120327110615.3bfaf969@eb-e6520>
 <20120327091425.GC6790@pengutronix.de>
 <20120327112342.73a85a1b@eb-e6520>
Message-ID: <20120327093644.GD6790@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> well I should have said "enough extensive" tests as I did a lot of tests
> on the 3 archs (i.MX25, i.MX35 and i.MX51). What I see here is that on
> i.MX35 and i.MX51 the problem is very easy to reproduce without
> extensive tests (card not detected) and that on i.MX25 it needs more
> tests as the card is properly detected.

Ah, okay, thanks for the clarification! Well, since you retested now and
found it is harder to trigger that could explain why nobody reported it
and why 2.6.39 seems to work (although it maybe doesn't). Thanks for
rechecking. If you submit the patch, you can add my

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

Best regards.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120327/7b294c8d/attachment.sig>
