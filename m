From: ananaza@iki.fi (Antti Miettinen)
Date: Tue, 24 Dec 2013 19:52:48 +0200
Subject: L1 & L2 cache flush sequence on CortexA5 MPcore w.r.t low power
 modes
In-Reply-To: <20120514162150.GA4654@e102568-lin.cambridge.arm.com> (Lorenzo
 Pieralisi's message of "Mon, 14 May 2012 17:21:50 +0100")
References: <CAF0TxboSEZuHO6mo-F=os9cvNCyAfVjs3j=SSLjgC7DV6Q_jow@mail.gmail.com>
 <20120514155022.GA3792@e102568-lin.cambridge.arm.com>
 <20120514155859.GA13860@n2100.arm.linux.org.uk>
 <20120514162150.GA4654@e102568-lin.cambridge.arm.com>
Message-ID: <87ha9yqgpb.fsf@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry to still bring up an old thread, but this still bothers me..

Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:
> [..] dirty cache lines can be migrated across
> processors caches. [..]

What are the conditions under which this can happen? Which CPUs in
reality migrate dirty lines between caches? And C==0 does prevent
migrations as well as local allocations?

	--Antti
