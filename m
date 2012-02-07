From: rostedt@goodmis.org (Steven Rostedt)
Date: Tue, 07 Feb 2012 07:32:56 -0500
Subject: [PATCH][RFC] tracing/rcu: Add trace_##name##__rcuidle() static
 tracepoint for inside rcu_idle_exit() sections
In-Reply-To: <20120206233804.GM5941@linux.vnet.ibm.com>
References: <20120202190708.GE2518@linux.vnet.ibm.com>
 <87obtgc1xx.fsf@ti.com> <4F2B1307.5010207@gmail.com>
 <1328223819.5882.133.camel@gandalf.stny.rr.com>
 <20120202232736.GL2518@linux.vnet.ibm.com>
 <1328237131.5882.135.camel@gandalf.stny.rr.com>
 <20120203060458.GF2380@linux.vnet.ibm.com>
 <1328295309.5882.178.camel@gandalf.stny.rr.com>
 <20120203194005.GK2382@linux.vnet.ibm.com>
 <1328563113.2200.39.camel@gandalf.stny.rr.com>
 <20120206233804.GM5941@linux.vnet.ibm.com>
Message-ID: <1328617976.2200.66.camel@gandalf.stny.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-02-06 at 15:38 -0800, Paul E. McKenney wrote:

> Aside from the "pre;" below needing to precede rcu_read_lock_sched_notrace()
> as Josh noted, this looks reasonable to me.
> 

Does this mean I can add an Acked-by from you and Josh? Obviously with
the post "pre" change.

-- Steve
