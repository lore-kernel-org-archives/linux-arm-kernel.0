From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 23 Apr 2012 11:06:31 +0000
Subject: [PATCH V2 1/3] lib: add support for stmp-style devices
In-Reply-To: <20120423072839.GC4568@pengutronix.de>
References: <1332368519-22660-1-git-send-email-w.sang@pengutronix.de>
 <20120422235506.d3377f0e.akpm@linux-foundation.org>
 <20120423072839.GC4568@pengutronix.de>
Message-ID: <201204231106.31574.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 23 April 2012, Wolfram Sang wrote:
> > But ./lib/ does seem rather a strange place for it.  Perhaps we need a
> > drivers/lib/ or something.  We can use ./lib/ for now - it can always
> > be moved later on.
> 
> The first version had it in drivers/base/ but that also felt strange.
> I like drivers/lib/. Arnd, do you agree? Shall I resend?

I think lib/ is fine, but I also suggested putting it there ;-)

If Andrew or someone else feels strongly about it, we can of course
change it again before I submit it to Linus.

	Arnd
