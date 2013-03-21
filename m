From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Mar 2013 16:51:47 +0000
Subject: [GIT PULL] Renesas ARM and SH based SoC pinmux update for v3.10
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <201303211651.47960.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 March 2013, Simon Horman wrote:

> ----------------------------------------------------------------
> Renesas ARM and SH based SoC pinmux update for v3.10
> 
> As with changes to the Renesas ARM and SH based SoC pinmux code for v3.9
> it has been agreed by the relevant parties, Linus Walleij, Laurent Pinchart,
> Paul Mundt and myself, that it would be best to take these changes through
> the renesas tree and in turn the arm-soc tree.
> 
> This pull is based on a merge of the following in order to provide
> the required dependencies. This base has been discussed and agreed upon by
> Linus Walleij, Laurent Pinchart and myself.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl devel
> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl fixes
> git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas fixes

Pulled, thanks!

I'm a bit overwhelmed by the number of patches and pull requests I got from
you at the same time, so it took a little longer to get an overview of what
you are actually doing.

I've used the next/renesas-pinctrl branch again, keeping this one separate
from the other next/* branches given how many patches there are in here,
and given the dependency on the pinctrl tree.

	Arnd
