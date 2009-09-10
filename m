From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 10 Sep 2009 21:19:32 +0200
Subject: [patch for 2.6.31] zaurus c3000 aka spitz: fix resume
In-Reply-To: <20090909182340.GA5235@n2100.arm.linux.org.uk>
References: <20090909075024.GA1400@ucw.cz>
	<f17812d70909090737n4315d0cbh82c0a63e9222fdb5@mail.gmail.com>
	<20090909182340.GA5235@n2100.arm.linux.org.uk>
Message-ID: <20090910191932.GA23721@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2009-09-09 19:23:40, Russell King - ARM Linux wrote:
> On Wed, Sep 09, 2009 at 10:37:41PM +0800, Eric Miao wrote:
> > On Wed, Sep 9, 2009 at 3:50 PM, Pavel Machek<pavel@ucw.cz> wrote:
> > > Hi, Linus!
> > >
> > > Spitz resume was broken for year or likely two, and it would be very
> > > nice to fix it for 2.6.31 release. One liner is below, and it really
> > > can not harm. It already is in Eric's fix queue, so pulling that for
> > > .31 should work, too.
> > >
> > 
> > This should be sitting in rmk's git tree and I'm not sure if Russell
> > has sent the pull request already.
> 
> It's just Pavel being his obnoxious impatient self...

Aha, Russell, being polite and helpful, as usual.

Only that, you know, you missed the deadline, so... perhaps I had
reason to be impatient?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
