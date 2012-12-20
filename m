From: olof@lixom.net (Olof Johansson)
Date: Thu, 20 Dec 2012 08:29:38 -0800
Subject: [GIT PULL] ARM: arm-soc fixes for 3.8
In-Reply-To: <20121220151059.GU4989@atomide.com>
References: <20121218065502.GA12865@quad.lixom.net>
 <50D08547.8040405@free-electrons.com>
 <20121220151059.GU4989@atomide.com>
Message-ID: <20121220162938.GA29578@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 20, 2012 at 07:10:59AM -0800, Tony Lindgren wrote:
> * Maxime Ripard <maxime.ripard@free-electrons.com> [121218 07:08]:
> > Hi Olof,
> > 
> > Le 18/12/2012 07:55, Olof Johansson a ?crit :
> > > Maxime Ripard (1):
> > >       ARM: sunxi: Change device tree naming scheme for sunxi
> > 
> > There's something odd about this one (commit 68136b10). The patch that
> > you seem to have applied differs from the one I sent. The DTs files
> > appears to have not been renamed, while in the patch I sent
> > (http://lists.infradead.org/pipermail/linux-arm-kernel/2012-December/137105.html),
> > it's the case.
> > 
> > Do you know what happened here? What can we do to fix that?
> 
> Looks like that's trivial to fix as needed, no need to rebuild
> the branch to fix that AFAIK.
> 
> The fix can be done once Olof is available online again.
> 
> Linus, I suggest that you go ahead and pull this if there are
> no other issues with this branch.

Sorry for being offline a bit longer than expected. Fresh pull request
coming in a minute.


-Olof
