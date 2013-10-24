From: matt.porter@linaro.org (Matt Porter)
Date: Thu, 24 Oct 2013 15:46:06 -0400
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <20131024150016.GB4096@netboy>
References: <20131022093923.GC15640@ulmo.nvidia.com>
 <20131022150426.GF29341@beef>
 <20131022171346.GE4061@obsidianresearch.com>
 <20131023080630.GA14413@netboy>
 <20131023172955.GA17145@obsidianresearch.com>
 <20131023174736.GD5208@netboy>
 <20131023180240.GA32563@obsidianresearch.com>
 <20131023182345.GG5208@netboy>
 <20131024083411.GH9403@ulmo.nvidia.com>
 <20131024150016.GB4096@netboy>
Message-ID: <20131024194606.GX29341@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 24, 2013 at 05:00:16PM +0200, Richard Cochran wrote:
> On Thu, Oct 24, 2013 at 10:34:12AM +0200, Thierry Reding wrote:
> > 
> > There's another thing with DT bindings that makes them needlessly hard
> > to settle on. Let's say you come up with a binding that accurately
> > describes the hardware at hand and has been proven to work. Now people
> > keep telling you that it might not be good enough, for whatever reason
> > so eventually you decide to be bold and tell them that you're aware of
> > everything that stable DT bindings imply and that there might be some
> > risk of having to maintain two bindings because the first one didn't
> > turn out to be perfect and yada yada.
> 
> You make a good point here. In my own limited experiences with DT
> kernel development, a big debate always emerged about exactly how
> these bindings should be called. Not being a real DT expert myself, I
> really couldn't understand what the point was, but I just implemented
> what the DT people wanted (or just dropped the submission altogether,
> in one case).
> 
> I think the frustration that you have experienced is simply a result
> of the attitude on the DT list. Maybe the real issue is attitude
> and personalities, and not the hurdle of stable bindings.

Well, you both hit on something here. There's no possible self-policing
of what is submitted as bindings.

There's really no canonical documentation on best practices. Most
bindings are inconsistent in format and deprecated in style of
content.

I'm not talking about referring back to ePAPR or the explanation of
compatible string best practices on devicetree.org. I'm talking about
all the decisions made in random threads. The "standards" and "best
practices" have not been documented like our kernel patch submission
process and best practices. As a result, people our generating
additional traffic with every new binding submission. Stephen had
a nice list of best practices but it's difficult to tell if that is
agreed on by *all* the DT maintainers or his personal preference. At
some point we need to agree on documentation for best practices acked
by the entire maintainer team.

-Matt
