From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 24 Feb 2010 12:07:39 -0700 (MST)
Subject: [GIT PULL] Second set of OMAP clock/hwmod patches for 2.6.34
In-Reply-To: <20100224190211.GS28173@atomide.com>
References: <alpine.DEB.2.00.1002241116000.2701@utopia.booyaka.com>
	<20100224190211.GS28173@atomide.com>
Message-ID: <alpine.DEB.2.00.1002241207020.2701@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 24 Feb 2010, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [100224 10:15]:
> > 
> > Hi Tony,
> > 
> > The following changes since commit 0482e3c6f704d25b6a4e3c940caeeacece4e6d74:
> >   Tony Lindgren (1):
> >         Merge branch 'omap-fixes-for-linus' into omap-for-linus
> > 
> > are available in the git repository at:
> > 
> >   git://git.pwsan.com/linux-2.6 for_2.6.34_b
> 
> Hmm this does not seem to merge without conflicts to omap-for-linus,
> maybe take a look if you can merge/rebase it?
> 
> I'd assume rebasing or merging your branch with
> 80c20d543d142ee54ec85259b77aaf0b83c32db5 will do the trick.

Looks like 4751227df948582e82f19df30efa662ab71fa980 is the problem.


- Paul
