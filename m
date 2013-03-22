From: horms@verge.net.au (Simon Horman)
Date: Fri, 22 Mar 2013 09:48:22 +0900
Subject: [GIT PULL] Renesas ARM and SH based SoC pinmux update for v3.10
In-Reply-To: <201303211651.47960.arnd@arndb.de>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
 <201303211651.47960.arnd@arndb.de>
Message-ID: <20130322004822.GD1689@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 04:51:47PM +0000, Arnd Bergmann wrote:
> On Monday 18 March 2013, Simon Horman wrote:
> 
> > ----------------------------------------------------------------
> > Renesas ARM and SH based SoC pinmux update for v3.10
> > 
> > As with changes to the Renesas ARM and SH based SoC pinmux code for v3.9
> > it has been agreed by the relevant parties, Linus Walleij, Laurent Pinchart,
> > Paul Mundt and myself, that it would be best to take these changes through
> > the renesas tree and in turn the arm-soc tree.
> > 
> > This pull is based on a merge of the following in order to provide
> > the required dependencies. This base has been discussed and agreed upon by
> > Linus Walleij, Laurent Pinchart and myself.
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl devel
> > git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl fixes
> > git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas fixes
> 
> Pulled, thanks!
> 
> I'm a bit overwhelmed by the number of patches and pull requests I got from
> you at the same time, so it took a little longer to get an overview of what
> you are actually doing.
> 
> I've used the next/renesas-pinctrl branch again, keeping this one separate
> from the other next/* branches given how many patches there are in here,
> and given the dependency on the pinctrl tree.

Thanks. Please note that some of my other branches are based
on this branch due to dependencies - some days it seems like everything
is dependant on everything else!
