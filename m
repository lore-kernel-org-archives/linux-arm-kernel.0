From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Sat, 29 Sep 2012 23:38:31 +0200
Subject: ARM SoC tree,
 Was: Re: [PATCH 05/12] ARM: ixp4xx: use __iomem for MMIO
In-Reply-To: <20120929174400.GA6933@n2100.arm.linux.org.uk> (Russell King's
 message of "Sat, 29 Sep 2012 18:44:01 +0100")
References: <1348868177-21205-1-git-send-email-arnd@arndb.de>
 <1348868177-21205-6-git-send-email-arnd@arndb.de>
 <m3lift6rru.fsf_-_@intrepid.localdomain>
 <201209291458.16112.arnd@arndb.de>
 <m3y5jskbir.fsf@intrepid.localdomain>
 <20120929174400.GA6933@n2100.arm.linux.org.uk>
Message-ID: <m3pq54jyqw.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I realize my work flow is probably suboptimal, though I can't see
an easy solution.

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> That makes no sense what so ever.  The tree which is used for the next
> stable tree will be Linus' tree, which will be the result of merging all
> those other trees into Linus' tree.  If you base your changes off only
> Linus' tree on the run up to the next merge window, then you are preparing
> your changes against an _older_ kernel than if you base them off a tree
> containing the changes which will be _included_ in the next merge
> window.

Yes. I have to fix my tree and ask for pull before the end of merge
window (fixes could follow, but it's best when there are no fixes
needed). I know it's not a great plan. Fortunately I'm not doing heavy,
conflicting development on this.

Note I'm not only doing ARM, but also X86 and MIPS, with additional code
shared between them, and the "stable" part of it is what I'm paid for.
I can't simply work with arm-soc, none of my platforms will even boot
with pure arm-soc.

> If you want to work in total isolation, that's your choice, but in the
> long run you will be playing catch-up rather than being prepared early
> for the changes which will happen at the next merge window.  If you want
> -rc1, rc2, rc3, rc4 etc to be broken on IXP4xx until you get around to
> fixing up the merge window breakage, then go ahead.
>
> Otherwise, participate and be part of the community, and get your changes
> into arm-soc, so that others can see what's going on.

Unfortunately this seems to require more time on my part, time I don't
have. Perhaps I'm missing something?
I.e., I can dedicate some time around the merge window (not every one,
but this may improve), but not much more.

I don't think there are any "others" interested in what's going on on
IXP4xx. Simply, there isn't anything of importance here. It won't cause
severe conflicts (and "next" helps here), and I post my patches to the
list just like all people do.

Of course if you can see a better way (given the limitations), I'm open.

BTW I still think I'm a part of the community, even if I don't submit
code through arm-soc :-)
-- 
Krzysztof Halasa
