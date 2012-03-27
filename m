From: eric@eukrea.com (Eric =?ISO-8859-1?B?QuluYXJk?=)
Date: Tue, 27 Mar 2012 11:23:42 +0200
Subject: [MX25][MMC] mmc esdhc failure in 3.3
In-Reply-To: <20120327091425.GC6790@pengutronix.de>
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
 <20120327091425.GC6790@pengutronix.de>
Message-ID: <20120327112342.73a85a1b@eb-e6520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Tue, 27 Mar 2012 11:14:25 +0200,
Wolfram Sang <w.sang@pengutronix.de> a ?crit :

> 
> > > Interesting question is now why it worked on your older kernel? The code
> > > around BROKEN_TIMEOUT is there for much longer, I'd think.
> > > 
> > not in fact it seems to have been broken from a long time and I think
> 
> I know and you are saying the same, in fact :) Your patch came in around
> 2.6.37 and here it was said that 2.6.39 works fine. Might be random,
> though.
> 
what is surprising is that no one reported this problem between 2.6.37
and 3.3

> > because unlike the i.MX35 it seems that the i.MX25 manages to read
> > properly the partition table even without the timeout quirk and it
> > seems that I didn't do more extensive tests for this patch.
> 
> Please do next time.
> 
well I should have said "enough extensive" tests as I did a lot of tests
on the 3 archs (i.MX25, i.MX35 and i.MX51). What I see here is that on
i.MX35 and i.MX51 the problem is very easy to reproduce without
extensive tests (card not detected) and that on i.MX25 it needs more
tests as the card is properly detected.

Eric
