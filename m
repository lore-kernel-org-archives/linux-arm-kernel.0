From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 23 Oct 2013 12:02:40 -0600
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <20131023174736.GD5208@netboy>
References: <5264576F.6050307@wwwdotorg.org>
 <alpine.LFD.2.03.1310201911190.1951@syhkavp.arg>
 <52658EBC.8020800@wwwdotorg.org>
 <alpine.LFD.2.03.1310211632460.1951@syhkavp.arg>
 <20131022093923.GC15640@ulmo.nvidia.com>
 <20131022150426.GF29341@beef>
 <20131022171346.GE4061@obsidianresearch.com>
 <20131023080630.GA14413@netboy>
 <20131023172955.GA17145@obsidianresearch.com>
 <20131023174736.GD5208@netboy>
Message-ID: <20131023180240.GA32563@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 23, 2013 at 07:47:37PM +0200, Richard Cochran wrote:
> On Wed, Oct 23, 2013 at 11:29:55AM -0600, Jason Gunthorpe wrote:
> > 
> > I've seen that nebulous answer before. It is awfully vauge. Don't you
> > think a better, more excting answer is required to commit the kernel
> > community to such a huge amount of work+pain?
> > 
> > What users? What use cases? Who exactly?
> 
> Gimme a break. The use case I mentioned is not at all vague. It is
> about a specific a use case as you'll ever see.

I can rephrase your use case as wanting to boot kernels M > N where N
is the first working mainline kernel. I think we all want that.

But it doesn't concretely tie back to stable DTB as the only possible
solution. As you pointed out we could do this with board.c files.

In other words, I don't think it is a compelling justification.

> > Crucially: Does the above justify the huge effort on the kernel side?
> 
> The effort is no more or less than is required of every other kernel
> development.

Bollocks. User space API development is the single most difficult
thing to do in the kernel. It is much harder than any other change,
and stable ABI DT is elevated to *that* level. 

Regards,
Jason
