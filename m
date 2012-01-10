From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 Jan 2012 09:06:35 +0000
Subject: [GIT PULL] Samsung devel for v3.3
In-Reply-To: <20120109161152.GA2974@opensource.wolfsonmicro.com>
References: <018801ccca70$25f01260$71d03720$%kim@samsung.com>
 <CAOesGMjn5uQEWbxrJryC+jOf=3SYbAnPY4A71NUZKFBi=a0QjA@mail.gmail.com>
 <01a301ccce6f$9bb51790$d31f46b0$%kim@samsung.com>
 <201201091556.34817.arnd@arndb.de>
 <20120109161152.GA2974@opensource.wolfsonmicro.com>
Message-ID: <20120110090635.GT21765@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2012 at 08:11:54AM -0800, Mark Brown wrote:
> On Mon, Jan 09, 2012 at 03:56:34PM +0000, Arnd Bergmann wrote:
> 
> > Of course we will take all bug fixes. Just rebase the rest on top of 3.3-rc1
> > and we can take it right away for 3.4.
> 
> I've sent a pull request earlier in the thread for the main ones I'm
> aware of (which are mostly fixes for things introduced in this cycle) -
> the others I'm aware of are all specific to Cragganmore and given that
> we can't get any of the features for that merged the fixes aren't going
> to have any practical effect until we can manage to get the feature
> stuff merged so it's not really worth the effort.
> 
> This really is very disappointing.

No it isn't.

What is really disappointing is the lack of responsive maintainers for the
Samsung stuff.  It took _two_ bloody months to get the Samsung platforms
sorted for the restart changes in spite of reminding, and a last minute
rush over the course of a couple of days (one _in_ the merge window) to
get it properly merged into my tree.

The only reason something happened was because I stuck a #error into
the Samsung code in linux-next and people started reporting that Samsung
had broken.

This is not the worst of it - Nicolas took _three_ months to get a response
from the shmobile maintainers.  I never got a response from the shmobile
maintainers for the restart changes - so congratulations to the shmobile
maintainers, shmobile is now broken.

The alternative was basically Samsung ending up like shmobile is today.
Maybe that's what should have happened to save folk like Arnd such a
horrible job now.

So, I support Arnd's view: the Samsung stuff is just too late.  Even the
restart updates (which is what has caused this) were too late.  Anything
which causes new merge conflicts in the Samsung code is not acceptable at
this point, even if it's a 'fix' patch.  We've wasted far too much time
trying to get Samsung stuff sorted far too late in the cycle.

Let this be an object lesson in what happens if you leave stuff until the
last minute.
