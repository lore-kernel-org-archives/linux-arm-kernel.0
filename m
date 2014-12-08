From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 8 Dec 2014 19:38:53 +0100
Subject: [PATCH v5 00/61] dmaengine: Implement generic slave capabilities
 retrieval
In-Reply-To: <20141208162843.GP16827@intel.com>
References: <1416231775-31252-1-git-send-email-maxime.ripard@free-electrons.com>
 <20141208061746.GD16827@intel.com> <20141208141807.GC8739@lukather>
 <20141208162843.GP16827@intel.com>
Message-ID: <20141208183853.GG8739@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 08, 2014 at 09:58:43PM +0530, Vinod Koul wrote:
> > > So bit sceptical for merging now. I will send the patches which I have
> > > applied on top of this
> > 
> > Which is why I wanted to merge this at the *beginning* of the
> > development cycle in the first place....
> > 
> > These patches have been sent more than 2 weeks ago, and were exactly
> > the same as the ones send at the end of October, rebased and updated
> > to take into account the drivers that were merged in between.
> > 
> > In short, these patches have been hanging around since 6 weeks. I
> > relied probably too much on the intel's build bot. This is not a
> > mistake I'll repeat. But blaming it on me because they came too late
> > is *very* unfair.
>
> as a first step one is expected to compile the patches we send. That is very
> basic stuff which should not be avoided.

Indeed. My mistake, it won't happen again.

> given that we had build failures on v5 rev of the series and serious
> failures flagged off by compilers doesn't inspire a lot of
> confidence.

v5 that you never reviewed, just like the v4, v3 and v2 before it.

> And lastly noone blamed you for being late, if things were rosy they
> would have been merged over the weekend and been in today's next,
> but...

I totally understand your point. And I actually am a bit uncomfortable
merging this so late too, and I'd actually prefer to have it merged
for 3.20. But this is a huge patchset, and I'd really like to avoid
rebasing it forever.

I'll send a v6, with your patches, as soon as 3.19-rc1 is out. This
will be my last rebase of this serie. If these patches are not merged
then, then I will just give up on this cleanup, and probably any
subsequent ones.

I'm sorry, but I just don't care enough.

Maxime.

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141208/cc8866b3/attachment.sig>
