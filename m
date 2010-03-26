From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 26 Mar 2010 10:30:47 +0100
Subject: [GIT PULL] generic arm for MSM
In-Reply-To: <20100326082300.GA6665@n2100.arm.linux.org.uk>
References: <1269553937.21793.40.camel@c-dwalke-linux.qualcomm.com>
	<alpine.LFD.2.00.1003251843320.694@xanadu.home>
	<1269557364.21793.52.camel@c-dwalke-linux.qualcomm.com>
	<20100325225300.GK24984@n2100.arm.linux.org.uk>
	<1269557655.21793.53.camel@c-dwalke-linux.qualcomm.com>
	<20100325225555.GL24984@n2100.arm.linux.org.uk>
	<1269559307.21793.78.camel@c-dwalke-linux.qualcomm.com>
	<20100326081445.GB20553@pengutronix.de>
	<20100326082300.GA6665@n2100.arm.linux.org.uk>
Message-ID: <20100326093047.GB14697@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

> There shouldn't be any problem; that tree is an identical copy of my
> local tree which uses no alternatives.  It always contains an entire
> set of Linus' tree with no additional repacking.
> 
> The only reason to pull this tree into a copy of Linus' tree is that
> it'll avoid fetching 400MB or so of Linus' pack files over http from
> the UK, instead only fetching 34MB of objects.
I looked some time ago and IIRC you had all of Linus' tree in a single
pack file.  This resulted in trying to download these 400MB even though
I only missed one day's worth of commits.  So today I always do

	git remote update linus rmk

which works well most of the time.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
