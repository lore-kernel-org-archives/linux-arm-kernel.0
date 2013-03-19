From: horms@verge.net.au (Simon Horman)
Date: Tue, 19 Mar 2013 11:16:49 +0900
Subject: [GIT PULL] Renesas ARM-based SoC fixes for v3.9
In-Reply-To: <201303181057.21955.arnd@arndb.de>
References: <1362757104-7498-1-git-send-email-horms+renesas@verge.net.au>
 <20130318103511.GB18676@verge.net.au>
 <201303181057.21955.arnd@arndb.de>
Message-ID: <20130319021649.GB4946@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 18, 2013 at 10:57:21AM +0000, Arnd Bergmann wrote:
> On Monday 18 March 2013, Simon Horman wrote:
> > On Fri, Mar 08, 2013 at 04:38:23PM +0100, Simon Horman wrote:
> > > Hi Olof, Hi Arnd,
> > > 
> > > The following changes since commit 6dbe51c251a327e012439c4772097a13df43c5b8:
> > > 
> > >   Linux 3.9-rc1 (2013-03-03 15:11:05 -0800)
> > > 
> > > are available in the git repository at:
> > > 
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git 
> > > 
> > > for you to fetch changes up to 44e9ac45754a182e8121bf137368452365d4cc4b:
> > > 
> > >   ARM: shmobile: marzen: Include mmc/host.h (2013-03-08 16:29:23 +0100)
> > > 
> > > ----------------------------------------------------------------
> > > Resolve a build failure present since v3.9-rc1
> > > 
> > > ----------------------------------------------------------------
> > > Simon Horman (1):
> > >       ARM: shmobile: marzen: Include mmc/host.h
> > 
> > Ping.
> 
> Ah, just in time. I think I tried pulling from the URL you listed
> above before, and git said "Already up-to-date.", so I didn't bother
> to look further.
> 
> Upon closer inspection, you seem to have missed the tag name. I have
> pulled your renesas-fixes-for-v3.9 tag into the arm-soc fixes branch
> now and will include it in my pull request to Linus today.

Sorry about that. I must have sent the pull request before the
tag hit kernel.org and failed to notice that the tag was missing
from the above email message.
