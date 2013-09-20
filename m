From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 20 Sep 2013 13:58:27 -0400
Subject: [GIT PULL] ARM: mvebu: fixes for v3.12
In-Reply-To: <CAOesGMi769sEAuf9SaZV_3+HPetDnv-wTb=Ckm1+YxzbZobPGA@mail.gmail.com>
References: <20130920034613.GB11119@titan.lakedaemon.net>
 <CAOesGMi769sEAuf9SaZV_3+HPetDnv-wTb=Ckm1+YxzbZobPGA@mail.gmail.com>
Message-ID: <20130920175827.GC11119@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 20, 2013 at 10:36:32AM -0700, Olof Johansson wrote:
> On Thu, Sep 19, 2013 at 8:46 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> > Guys,
> >
> > We have a relatively long list of fixes this time around.  The two
> > of_node_put()'s were left over from before the merge window (part of
> > mvebu/fixes-non-critical).
> >
> > The two for the Armada XP clocks are to fix booting v3.12-rc1 since the
> > corresponding driver changes were merged at the last minute.  These were
> > originally part of mvebu/dt for v3.12, but have since become fixes.
> >
> > The other two just cropped up since v3.12-rc1 dropped.
> 
> 
> Pulled, thanks.
> 
> I noticed a couple of the patches had conflict messages in the patch
> description. They're sometimes useful on merges but less so on patches
> (likely just from needing fixups when cherry-picked?). Not a big deal,
> but something to keep in mind in the future.

Yes, I left them in because I was moving them from one merge window to
another and decided to err on the side of 'more info is better' in case
a bisect came across them.

I can leave them out as well.  I have no strong opinion on it.

thx,

Jason.
