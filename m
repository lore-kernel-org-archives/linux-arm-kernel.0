From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 18 Sep 2012 13:24:26 -0400
Subject: [GIT PULL V2 1/4] ARM: Kirkwood: DT bindings for v3.7
In-Reply-To: <20120913053045.GB24290@quad.lixom.net>
References: <20120829001129.GO19437@titan.lakedaemon.net>
 <20120910054835.GC15277@titan.lakedaemon.net>
 <20120913053045.GB24290@quad.lixom.net>
Message-ID: <20120918172426.GL5469@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2012 at 10:30:45PM -0700, Olof Johansson wrote:
> On Mon, Sep 10, 2012 at 01:48:35AM -0400, Jason Cooper wrote:
> > Arnd, Olof,
> > 
> > This branch depends on arm/cache-l2x0 which is going in through rmk's
> > tree.  arm/cache-l2x0 contains the following from Gregory Clement:
> > 
> > 	arm: cache-l2x0: make outer_cache_fns a field of l2x0_of_data
> > 	arm: cache-l2x0: add an optional register to save/restore
> 
> Ok, we need to make sure that Russell is happy with the patches and
> is pulling them in (with an agreement to not rebase the merged branch)
> before we can pull in your branch that builds on it.

Arnd, Olof,

Ok, I'm still mastering the art of branch dependencies.  The acceptance
of Gregory's cache-l2x0 series is holding up everything else.
Rightfully so, rmk has some issues with it.

However, in my pullrqs and in my branch merging I treated it as a
dependency for everything that came after it (pr 1,2,3,4).  I'd like to
undo that now to get things moving.  The dependency was not strictly
necessary, I was simply trying to achieve an ordering of branches.

The only way I know to do this is to redo my branches and republish.
Basically, I would remove Gregory's patches and the dependency on 'arm:
cache-l2x0' from pullrq [1/4] Kirkwood DT bindings.

Obviously, this would break things for folks tracking my branches.
Hopefully anyone crazy enough to track my branches is competent enough
rebase onto the new branches.  Even still, I don't want to mess anyone up.

I think the benefits of getting these patches in for this merge window
outweigh a onetime breaking of my branches.  Is there anything I'm not
considering before I do this?

I'll do the work now, but hold off on pushing or sending new pullrq's
for a day or two or until I hear from you guys.

thx,

Jason.
