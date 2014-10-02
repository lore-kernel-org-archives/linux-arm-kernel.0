From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 2 Oct 2014 16:50:08 -0400
Subject: [GIT PULL] ARM: mvebu: Last DT changes for v3.18
In-Reply-To: <1850328.rMhfjqiuR3@wuerfel>
References: <20141002135926.GC27230@titan.lakedaemon.net>
 <1850328.rMhfjqiuR3@wuerfel>
Message-ID: <20141002205008.GA3895@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 02, 2014 at 05:20:53PM +0200, Arnd Bergmann wrote:
> On Thursday 02 October 2014 09:59:26 Jason Cooper wrote:
> > 
> > I know this is way late, but the changes a fairly small, and have been
> > in linux-next for at least 9 of Stephen's 'next-YYYYMMDD' tags.
> > Hopefully the merge window opening a week late will make it possible for
> > you guys to take this.
> > 
> > This is an incremental pull request from tags/mvebu-dt-3.18 up to
> > tags/mvebu-dt-3.18-2 on the mvebu/dt branch.
> 
> The one patch is a bug fix, so it's exempt from the deadline, the other
> one is obviously harmless, so I'm pulling it into next/dt.

Thanks!

> Regarding the DT change: Seriously? They made the same mistake
> *AGAIN*? I hope that whoever at Marvell decided to change the
> register location for a shipping product in a boot loader update
> will lose their commit access.

You're assuming they use version control.  I wouldn't give them that
much credit.  ;-)

thx,

Jason.
