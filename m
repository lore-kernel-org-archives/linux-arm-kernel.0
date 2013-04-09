From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 Apr 2013 23:20:06 +0200
Subject: [GIT PULL 0/10] Samsung stuff for v3.10
In-Reply-To: <516309C4.3000008@samsung.com>
References: <516309C4.3000008@samsung.com>
Message-ID: <201304092320.06222.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 April 2013, Kukjin Kim wrote:
> 
> Hi Arnd, Olof
> 
> This is 2nd pull-request for Samsung stuff for v3.10.
> 
> If any problems, please kindly let me know.

I managed to pull them all in, aside from the 6/10, since you asked us
to defer that one. There were a lot more small mistakes, and I think
I've managed to fix them all up, but please check if the for-next
branch now actually works.

A few more requests for the future:

* Please send branches earlier. You already sent a number of them
very early, but then we saw very little until now. I'd rather
get a number of follow-on pull requests than getting everything
at once, which has lead to stuff getting rejected in the past
when things break, as you remember. I've been waiting for
ages now to rebase my multiplatform series on the things you
have in your tree, I hope we can still make it in time.

* Half a sentence of tag description is not really enough for
a long series. Please explain in the tag what the purpose of
the series is, as you do for a patch.

* Mention interdependencies between branches explicitly. It
causes us a lot of extra work having to find out what patches
are actually new in a series when you have based them on earlier
patches.

* Look at the patches that are already merged and test them.
I've had to fix up build errors now that have been present
in linux-next for multiple weeks.

	Arnd
