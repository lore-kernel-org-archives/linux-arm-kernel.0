From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 6 Dec 2013 01:53:19 +0100
Subject: [PATCH 0/5] PM: Enable option of re-use runtime PM callbacks
 at system suspend
In-Reply-To: <Pine.LNX.4.44L0.1312051720330.869-100000@iolanthe.rowland.org>
References: <CAJvTdKnqD3ccPUzh7kNMNqrEYFfD93Vh9hgFuKyHz+pjGNHdtA@mail.gmail.com>
 <Pine.LNX.4.44L0.1312051720330.869-100000@iolanthe.rowland.org>
Message-ID: <20131206005318.GB27953@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 2013-12-05 17:21:50, Alan Stern wrote:
> On Thu, 5 Dec 2013, Len Brown wrote:
> 
> > This thread raises the question...
> > 
> > Do we still need to have PM_RUNTIME apart from PM_SLEEP?
> > 
> > What is the benefit of being able to build-in one one without the other?
> > If that benefit is not significant, perhaps the time has come to
> > replace them both with CONFIG_PM...
> 
> There are lots of embedded/SoC platforms that implement PM_RUNTIME but
> not PM_SLEEP.

And lots of PCs where PM_SLEEP is useful but PM_RUNTIME is not :-).
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
