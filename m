From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 30 Dec 2014 09:36:54 -0500
Subject: [GIT PULL] mvebu: Fixes for -rc3
In-Reply-To: <20141229211047.GA18826@lunn.ch>
References: <20141229211047.GA18826@lunn.ch>
Message-ID: <20141230143654.GH28117@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew,

On Mon, Dec 29, 2014 at 10:10:47PM +0100, Andrew Lunn wrote:
> Hi Folks
> 
> Jason is taking a back seat this cycle and i'm doing all the patch
> wrangling for mvebu.
> 
> Here is a pull request for fixes for 3.19. Just one patch.
> 
> Please let me know if i've done anything wrong.
> 
>        Andrew
> 
> The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:
> 
>   Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)
> 
> are available in the git repository at:
> 
>   ssh://git.infradead.org/srv/git/linux-mvebu.git tags/mvebu-fixes-3.19

Sebastian already mentioned ssh/git url.

> 
> for you to fetch changes up to d4b0833a65e8b9fc58d992ba0cc89cad1580db31:
> 
>   ARM: mvebu: Fix pinctrl configuration for Armada 370 DB (2014-12-21 06:01:05 -0600)
> 
> ----------------------------------------------------------------
> Fixes for 3.19
> 

Arnd and Olof typically take info out of the tag when building their
summary text.  It's helpful to them, even though it looks redundant
here, to add a short summary of the changes in the tag itself.

> ----------------------------------------------------------------
> Gregory CLEMENT (1):
>       ARM: mvebu: Fix pinctrl configuration for Armada 370 DB
> 
>  arch/arm/boot/dts/armada-370-db.dts | 24 ------------------------

Minor nit here (sorry I couldn't respond yesterday): I try to do the
tags in the commit message in chronological order.  This commit has:

"""
    ...

    Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
    [andrew at lunn.ch: Correct commit IDs]
    Signed-off-by: Andrew Lunn <andrew@lunn.ch>
    Fixes: 4904a82a9399 ("arm: mvebu: move Armada 370/XP pinctrl node definition armada-370-xp.dtsi")
"""

It's more intuitive to a future reader to have:

"""
    ...

    [andrew at lunn.ch: Correct commit IDs]

    Fixes: 4904a82a9399 ("arm: mvebu: move Armada 370/XP pinctrl node definition armada-370-xp.dtsi")
    Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
    Signed-off-by: Andrew Lunn <andrew@lunn.ch>
"""

I can't find Gregory's email in my archive atm, so the above is if he
added the 'Fixes' tag.  If you added it, then it would go in between his
S-o-B and yours.

thx,

Jason.
