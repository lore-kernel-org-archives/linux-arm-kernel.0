From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Fri, 17 Jun 2016 05:58:25 -0700
Subject: ARM and OMAP patches to avoid lockdep complaints
In-Reply-To: <20160617040708.GA22406@atomide.com>
References: <20160615210926.GA30957@linux.vnet.ibm.com>
 <20160617040708.GA22406@atomide.com>
Message-ID: <20160617125825.GT3923@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 16, 2016 at 09:07:09PM -0700, Tony Lindgren wrote:
> Hi,
> 
> * Paul E. McKenney <paulmck@linux.vnet.ibm.com> [160615 14:11]:
> > Hello!
> > 
> > Ingo was not comfortable taking these through -tip, which is understandable,
> > given that they don't depend on each other or on anything else not already
> > in mainline, and that they don't have anything to do with -tip.
> > 
> > So what would you guys like to do with these?
> 
> I'll merge it into omap-for-v4.7/fixes thanks.

Thank you, Tony!

							Thanx, Paul

> Regards,
> 
> Tony
> 
> > They may be pulled from 7c64cc0531fa (arm: Use _rcuidle for
> > smp_cross_call() tracepoints) in my -rcu tree:
> > 
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
> > 
> > 							Thanx, Paul
> > 
> 
