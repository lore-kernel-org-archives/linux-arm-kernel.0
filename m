From: richardcochran@gmail.com (Richard Cochran)
Date: Wed, 23 Oct 2013 20:23:47 +0200
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <20131023180240.GA32563@obsidianresearch.com>
References: <alpine.LFD.2.03.1310201911190.1951@syhkavp.arg>
 <52658EBC.8020800@wwwdotorg.org>
 <alpine.LFD.2.03.1310211632460.1951@syhkavp.arg>
 <20131022093923.GC15640@ulmo.nvidia.com>
 <20131022150426.GF29341@beef>
 <20131022171346.GE4061@obsidianresearch.com>
 <20131023080630.GA14413@netboy>
 <20131023172955.GA17145@obsidianresearch.com>
 <20131023174736.GD5208@netboy>
 <20131023180240.GA32563@obsidianresearch.com>
Message-ID: <20131023182345.GG5208@netboy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 23, 2013 at 12:02:40PM -0600, Jason Gunthorpe wrote:
> On Wed, Oct 23, 2013 at 07:47:37PM +0200, Richard Cochran wrote:
> > 
> > The effort is no more or less than is required of every other kernel
> > development.
> 
> Bollocks. User space API development is the single most difficult
> thing to do in the kernel. It is much harder than any other change,
> and stable ABI DT is elevated to *that* level. 

Yes, that is the kind of effort needed. It comes with the territory.
System calls and ioctls are added all the time. Yes, they do require
some thought and review to get them right.

Creating new DT bindings also requires effort, but I don't agree with
the idea of making a mess for the end user just to avoid this effort.

Thanks,
Richard
