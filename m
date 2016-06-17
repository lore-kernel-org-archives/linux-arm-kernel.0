From: tony@atomide.com (Tony Lindgren)
Date: Thu, 16 Jun 2016 21:07:09 -0700
Subject: ARM and OMAP patches to avoid lockdep complaints
In-Reply-To: <20160615210926.GA30957@linux.vnet.ibm.com>
References: <20160615210926.GA30957@linux.vnet.ibm.com>
Message-ID: <20160617040708.GA22406@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Paul E. McKenney <paulmck@linux.vnet.ibm.com> [160615 14:11]:
> Hello!
> 
> Ingo was not comfortable taking these through -tip, which is understandable,
> given that they don't depend on each other or on anything else not already
> in mainline, and that they don't have anything to do with -tip.
> 
> So what would you guys like to do with these?

I'll merge it into omap-for-v4.7/fixes thanks.

Regards,

Tony

> They may be pulled from 7c64cc0531fa (arm: Use _rcuidle for
> smp_cross_call() tracepoints) in my -rcu tree:
> 
> 	git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
> 
> 							Thanx, Paul
> 
