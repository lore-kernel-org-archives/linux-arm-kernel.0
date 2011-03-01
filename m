From: hjk@hansjkoch.de (Hans J. Koch)
Date: Tue, 1 Mar 2011 23:22:29 +0100
Subject: [PATCH v7 1/1] PRUSS UIO driver support
In-Reply-To: <alpine.LFD.2.00.1103012238360.2701@localhost6.localdomain6>
References: <1299014895-2022-1-git-send-email-pratheesh@ti.com>
	<1299014895-2022-2-git-send-email-pratheesh@ti.com>
	<alpine.LFD.2.00.1103012238360.2701@localhost6.localdomain6>
Message-ID: <20110301222229.GE20497@local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 01, 2011 at 10:45:25PM +0100, Thomas Gleixner wrote:
> 
> > +
> > +	spin_lock_init(&lock);
> 
> Sigh. DEFINE_SPINLOCK(lock); already initializes the lock.
> 
> It's not the purpose of a review to tell you what you need to change
> mechanically. Reviewers hint to a correct solution and you are
> supposed to lookup what that solution means and act accordingly. If
> you do not understand the hint or its implications please ask _before_
> sending a new patch set.

Correct. But I'm to blame here, too, since I suggested the wrong solution.
Sorry for that, Gangadhar!

Thanks,
Hans
