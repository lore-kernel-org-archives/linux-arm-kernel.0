From: davem@davemloft.net (David Miller)
Date: Fri, 11 Apr 2014 13:43:35 -0400 (EDT)
Subject: [RFC PATCH] uprobes: copy to user-space xol page with proper
 cache flushing
In-Reply-To: <20140411153041.GQ16119@n2100.arm.linux.org.uk>
References: <20140411145625.GA27493@redhat.com>
 <20140411152207.GA28188@redhat.com>
 <20140411153041.GQ16119@n2100.arm.linux.org.uk>
Message-ID: <20140411.134335.706178936089846748.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Fri, 11 Apr 2014 16:30:41 +0100

> | Given that we've already solved that problem, wouldn't it be a good idea
> | if the tracing code would stop trying to reinvent broken solutions to
> | problems we have already solved?
> 
> I fail to see what your problem is with keeping the vma around, and
> using that infrastructure.  If it needs optimisation for uprobes, then
> let's optimise it.  Let's not go inventing a whole new interface
> solving the same problem.

+1
