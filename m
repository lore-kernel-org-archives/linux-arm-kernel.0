From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Thu, 14 Apr 2016 14:40:54 -0700
Subject: [PATCH] documentation: Add disclaimer
In-Reply-To: <15882.1453906627@warthog.procyon.org.uk>
References: <20160114120445.GB15828@arm.com> <56980145.5030901@imgtec.com>
 <20160114204827.GE3818@linux.vnet.ibm.com>
 <56981212.7050301@imgtec.com>
 <20160114222046.GH3818@linux.vnet.ibm.com>
 <20160126102402.GE6357@twins.programming.kicks-ass.net>
 <20160126103200.GI6375@twins.programming.kicks-ass.net>
 <20160126110053.GA21553@arm.com>
 <20160126201143.GV4503@linux.vnet.ibm.com>
 <15882.1453906627@warthog.procyon.org.uk>
Message-ID: <20160414214054.GB31866@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2016 at 02:57:07PM +0000, David Howells wrote:
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > +==========
> > +DISCLAIMER
> > +==========
> > +
> > +This document is not a specification; it is intentionally (for the sake of
> > +brevity) and unintentionally (due to being human) incomplete. This document is
> > +meant as a guide to using the various memory barriers provided by Linux, but
> > +in case of any doubt (and there are many) please ask.
> > +
> > +I repeat, this document is not a specification of what Linux expects from
> > +hardware.
> 
> The purpose of this document is twofold:
> 
>  (1) to specify the minimum functionality that one can rely on for any
>      particular barrier, and
> 
>  (2) to provide a guide as to how to use the barriers that are available.
> 
> Note that an architecture can provide more than the minimum requirement for
> any particular barrier, but if the barrier provides less than that, it is
> incorrect.
> 
> Note also that it is possible that a barrier may be a no-op for an
> architecture because the way that arch works renders an explicit barrier
> unnecessary in that case.
> 
> > +
> 
> Can you bung an extra blank line in here if you have to redo this at all?

Done as part of your patch.  Again, apologies for the delay.

							Thanx, Paul

> > +========
> > +CONTENTS
> > +========
> >  
> >   (*) Abstract memory access model.
> >  
> 
> David
> 
