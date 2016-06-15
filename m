From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Wed, 15 Jun 2016 14:09:26 -0700
Subject: ARM and OMAP patches to avoid lockdep complaints
Message-ID: <20160615210926.GA30957@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

Ingo was not comfortable taking these through -tip, which is understandable,
given that they don't depend on each other or on anything else not already
in mainline, and that they don't have anything to do with -tip.

So what would you guys like to do with these?

They may be pulled from 7c64cc0531fa (arm: Use _rcuidle for
smp_cross_call() tracepoints) in my -rcu tree:

	git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git

							Thanx, Paul
