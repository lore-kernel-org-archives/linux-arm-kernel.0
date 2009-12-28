From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 28 Dec 2009 21:52:57 +0100
Subject: tree with htc dream support
In-Reply-To: <20091228204848.GB1637@ucw.cz>
References: <d6200be20912142234ia050c67p34fd2672e7248170@mail.gmail.com>
	<20091227093537.GD11737@elf.ucw.cz>
	<20091227201514.GA29174@elf.ucw.cz>
	<a55d774e0912271220p1d102b1dr398e0524c9386702@mail.gmail.com>
	<20091227203704.GK11737@elf.ucw.cz>
	<20091227211322.GB29174@elf.ucw.cz>
	<a55d774e0912271646m1b82687cy427083e64e91e323@mail.gmail.com>
	<20091227101824.GB1478@ucw.cz>
	<a55d774e0912281224y7360dfdbu8a251743026bdd28@mail.gmail.com>
	<20091228204848.GB1637@ucw.cz>
Message-ID: <20091228205257.GA1862@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2009-12-28 21:48:48, Pavel Machek wrote:
> Hi!
> 
> > >> > Switch smd code to the version in staging. Something to apply to
> > >> > dream/ tree I'd say... and yes, it still works.
> > >>
> > >> I think we might want to consider leaving at least the core smd code
> > >> under mach-msm.
> > >
> > > In the long run, I agree.
> > >
> > > In the short run... the code is staging quality, so it should be in
> > > staging... and you'll not have to mainain so huge diff. (-20 kLoc).
> > 
> > The core smd stuff is really not that large.  The central smd.[ch] are
> > about 1300 lines, and proc_comm.[ch] are about 400 lines.  Is it
> > possible to get some review/feedback as to what's "staging quality"
> > about this code so we can clean it up?  I'd rather just fix the
> > issues
> 
> Just submit it to Daniel W., ccing rmk and l-a-k, and I'm sure you'll
> get feedback.
> 
> For a start, checkpatch has some mild complains. 

BTW if would be cool to fix style in the staging/, then do git mv, so
that cleanups are clearly separated/changelogged in kernel proper... 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
