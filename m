From: matt.porter@linaro.org (Matt Porter)
Date: Wed, 23 Oct 2013 16:12:53 -0400
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <20131023180507.GE5208@netboy>
References: <52658EBC.8020800@wwwdotorg.org>
 <alpine.LFD.2.03.1310211632460.1951@syhkavp.arg>
 <20131022093923.GC15640@ulmo.nvidia.com>
 <20131022150426.GF29341@beef>
 <20131022171346.GE4061@obsidianresearch.com>
 <20131023080630.GA14413@netboy>
 <20131023094903.GD11954@ulmo.nvidia.com>
 <20131023171620.GA5208@netboy> <20131023172558.GK29341@beef>
 <20131023180507.GE5208@netboy>
Message-ID: <20131023201253.GQ29341@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 23, 2013 at 08:05:08PM +0200, Richard Cochran wrote:
> On Wed, Oct 23, 2013 at 01:25:58PM -0400, Matt Porter wrote:
> > 
> > No, please, no!
> 
> On the one hand, I agree with you that the arago work is kind of scary
> to look at, but on the other hand, it is being used in tons of beagle
> bones and other devices. It is a success, of sorts.
> 
> I know of commercial products shipping with the arago kernel (not
> mine, of course). The chip vendors have a legitimate need to offer
> *something* that boots on their new devices. The BSP development has
> to be done quickly (and, more importantly, it cannot cost much
> either).
> 
> There is really nothing wrong with non-mainline trees. If they serve
> someone's needs, then they do get used.

Please don't confuse what is in arago trees (or the beagleboard.org
trees) and being aligned with what is happening upstream.

You are implying that there is some development happening there that is
closely tied to submission of candidate patches upstream. Those trees
have all been dumping grounds for patches that by and large go no where.

The context of this discussion is upstream process. No where did I
suggest that they lacked value for production.

-Matt
