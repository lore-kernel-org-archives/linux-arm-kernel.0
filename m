From: mturquette@ti.com (Mike Turquette)
Date: Fri, 6 Jul 2012 19:32:01 -0700
Subject: [PATCH] ARM: PRIMA2: convert to common clk and finish full clk
 tree
In-Reply-To: <CAGsJ_4x=GuY4RPk+SaWisoar1Qb0Y8ox0TqXN2hbsNvOHi_J4Q@mail.gmail.com>
References: <1341568806-842-1-git-send-email-Barry.Song@csr.com>
 <20120707013110.GB1230@gmail.com>
 <CAGsJ_4x=GuY4RPk+SaWisoar1Qb0Y8ox0TqXN2hbsNvOHi_J4Q@mail.gmail.com>
Message-ID: <20120707023201.GC1230@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20120707-10:23, Barry Song wrote:
> hi Mike,
> 
> 2012/7/7 Mike Turquette <mturquette@ti.com>:
> > On 20120706-18:00, Barry Song wrote:
> >> From: Binghua Duan <Binghua.Duan@csr.com>
> >>
> >> Commit 02c981c07bc95ac1e only implements a little part of primaII clk tree
> >> due to common clk framework was not ready at that time.
> >> This patch converts the old driver to common clk and finish the full clk
> >> tree.
> >>
> >> Signed-off-by: Binghua Duan <Binghua.Duan@csr.com>
> >> Signed-off-by: Barry Song <Barry.Song@csr.com>
> >
> > Hi Barry,
> >
> > I took a quick look through this patch and nothing jumped out at me, so
> > I've applied it to clk-next after a compile test with prima2_defconfig.
> > I also fixed up a bit of whitespace that got appended to
> > arch/arm/mach-prima2/clock.c.
> 
> thanks! it seems people like moving it to drivers/clk? so i'm ok if we
> "git mv" it and change drivers/clk/Makefile to include it if PRIMA2 is
> selected. if you want that, i can send a patch based on your clk-next
> with this commit.
> 

I don't mind dropping your patches from clk-next and taking new ones.
Go ahead and send me a new patch which does everything instead of an
incremental patch to simply 'git mv' the code.  Feel free to split the
patch up if needed.

Regards,
Mike

> >
> > Regards,
> > Mike
> >
> 
> -barry
