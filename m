From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 24 Oct 2013 10:34:12 +0200
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <20131023182345.GG5208@netboy>
References: <52658EBC.8020800@wwwdotorg.org>
 <alpine.LFD.2.03.1310211632460.1951@syhkavp.arg>
 <20131022093923.GC15640@ulmo.nvidia.com>
 <20131022150426.GF29341@beef>
 <20131022171346.GE4061@obsidianresearch.com>
 <20131023080630.GA14413@netboy>
 <20131023172955.GA17145@obsidianresearch.com>
 <20131023174736.GD5208@netboy>
 <20131023180240.GA32563@obsidianresearch.com>
 <20131023182345.GG5208@netboy>
Message-ID: <20131024083411.GH9403@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 23, 2013 at 08:23:47PM +0200, Richard Cochran wrote:
> On Wed, Oct 23, 2013 at 12:02:40PM -0600, Jason Gunthorpe wrote:
> > On Wed, Oct 23, 2013 at 07:47:37PM +0200, Richard Cochran wrote:
> > > 
> > > The effort is no more or less than is required of every other kernel
> > > development.
> > 
> > Bollocks. User space API development is the single most difficult
> > thing to do in the kernel. It is much harder than any other change,
> > and stable ABI DT is elevated to *that* level. 
> 
> Yes, that is the kind of effort needed. It comes with the territory.
> System calls and ioctls are added all the time. Yes, they do require
> some thought and review to get them right.
> 
> Creating new DT bindings also requires effort, but I don't agree with
> the idea of making a mess for the end user just to avoid this effort.

There's another thing with DT bindings that makes them needlessly hard
to settle on. Let's say you come up with a binding that accurately
describes the hardware at hand and has been proven to work. Now people
keep telling you that it might not be good enough, for whatever reason
so eventually you decide to be bold and tell them that you're aware of
everything that stable DT bindings imply and that there might be some
risk of having to maintain two bindings because the first one didn't
turn out to be perfect and yada yada.

So you are actually prepared to take the risk of having to maintain two
different bindings and do all the work to get a new feature supported.
Now people tell you that you can't do that either because you might not
be around forever and some poor sod will have to maintain it for you.

What do you do then? You try to convince people that we are in a big
mess right now and that we need to find a way out of it.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131024/3fe22272/attachment.sig>
