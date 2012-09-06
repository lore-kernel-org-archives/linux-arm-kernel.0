From: horms@verge.net.au (Simon Horman)
Date: Thu, 6 Sep 2012 15:18:07 +0900
Subject: [GIT PULL] Renesas ARM-based SoC: KZM-A9-GT for 3.7 #2
In-Reply-To: <CACRpkdZBOjO124w3WwPpL7ekf2dU1w2HCub9EG=LUxFSPn8Ayw@mail.gmail.com>
References: <1346305648-25263-1-git-send-email-horms@verge.net.au>
 <20120905224413.GC32084@quad.lixom.net>
 <CACRpkdZBOjO124w3WwPpL7ekf2dU1w2HCub9EG=LUxFSPn8Ayw@mail.gmail.com>
Message-ID: <20120906061807.GA3326@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 06, 2012 at 07:58:02AM +0200, Linus Walleij wrote:
> On Thu, Sep 6, 2012 at 12:44 AM, Olof Johansson <olof@lixom.net> wrote:
> 
> > So, we can't pull in this branch with its dependency without an agreement that
> > Linus holds a branch stable with at least the pcf857x patch on it. Linus?
> 
> OMG! OK let's claim that it's stable now then, it's close enough
> to the merge window.
> 
> Ironically his was caused by a Samsung commit (IIRC) which I
> applied to the GPIO tree but shouldn't be there (instead to be
> funneled through ARM SoC) so I had to take it out after
> a week. So maybe we're not so good off with these mixtures
> of "ARM SoC pulls GPIO" vs "ACK and push it all through ARM SoC"
> hm, maybe it's just one of those things we have to live with...

It seems to me that I should rebase the my branch and it can
then go through either the ARM SoC or GPIO tree. Either is fine by me.

As an aside, the patch does include a defconfig change.
Olof, Should that be broken out into a separate patch?
