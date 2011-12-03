From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 3 Dec 2011 22:46:54 +0000
Subject: [GIT PULL] ARM perf updates for 3.3
In-Reply-To: <20111203102154.GB3860@mudshark.cambridge.arm.com>
References: <20111202170231.GP5540@mudshark.cambridge.arm.com>
 <20111203092659.GL9581@n2100.arm.linux.org.uk>
 <20111203102154.GB3860@mudshark.cambridge.arm.com>
Message-ID: <20111203224654.GN9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 03, 2011 at 10:21:54AM +0000, Will Deacon wrote:
> On Sat, Dec 03, 2011 at 09:26:59AM +0000, Russell King - ARM Linux wrote:
> > While merging this, I get conflicts in gic.c and omap's common.h.  I'm
> > intending to resolve them as below - please check this _before_ I commit
> > it (which means my tree is frozen until this is resolved.)
> 
> This doesn't sound quite right since I don't touch either of these files in
> my perf changes. I suspect that you're getting changes from your recently
> merged fixes branch back from my tree, which is based on -rc4.

Yes, that'll be why.  I sent my previous message to Tony so he can
confirm the resolution himself.

The unfortunate thing about that is I can't complete the merge at the
moment, so I can't do anything with my git tree until Tony replies.
(I could abort the merge, but then I'd have to recreate the resolutions
which could be error prone.)

> As it happens, I worked on this with Marc and that resolution looks ok to
> me, although I don't have a board at hand to test it.

Well, I guess Tony won't reply until Monday afternoon, so there's no
immediate rush this weekend.
