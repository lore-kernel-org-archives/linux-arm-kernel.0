From: josh@joshtriplett.org (Josh Triplett)
Date: Tue, 7 Feb 2012 06:40:17 -0800
Subject: [PATCH][RFC] tracing/rcu: Add trace_##name##__rcuidle() static
 tracepoint for inside rcu_idle_exit() sections
In-Reply-To: <1328617976.2200.66.camel@gandalf.stny.rr.com>
References: <4F2B1307.5010207@gmail.com>
 <1328223819.5882.133.camel@gandalf.stny.rr.com>
 <20120202232736.GL2518@linux.vnet.ibm.com>
 <1328237131.5882.135.camel@gandalf.stny.rr.com>
 <20120203060458.GF2380@linux.vnet.ibm.com>
 <1328295309.5882.178.camel@gandalf.stny.rr.com>
 <20120203194005.GK2382@linux.vnet.ibm.com>
 <1328563113.2200.39.camel@gandalf.stny.rr.com>
 <20120206233804.GM5941@linux.vnet.ibm.com>
 <1328617976.2200.66.camel@gandalf.stny.rr.com>
Message-ID: <20120207144017.GA8658@leaf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 07, 2012 at 07:32:56AM -0500, Steven Rostedt wrote:
> On Mon, 2012-02-06 at 15:38 -0800, Paul E. McKenney wrote:
> 
> > Aside from the "pre;" below needing to precede rcu_read_lock_sched_notrace()
> > as Josh noted, this looks reasonable to me.
> > 
> 
> Does this mean I can add an Acked-by from you and Josh? Obviously with
> the post "pre" change.

With the pre change:

Reviewed-by: Josh Triplett <josh@joshtriplett.org>
