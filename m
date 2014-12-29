From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 29 Dec 2014 22:37:01 +0100
Subject: [GIT PULL] mvebu: Fixes for -rc3
In-Reply-To: <20141229211047.GA18826@lunn.ch>
References: <20141229211047.GA18826@lunn.ch>
Message-ID: <14a97faf4f0.2778.107cef0f820c2f5d7b7f41463071c310@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On December 29, 2014 10:12:29 PM Andrew Lunn <andrew@lunn.ch> wrote:

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

Andrew,

This should be the public git URL, they can't do anything with the ssh URL. 
It's a common mistake, but I suggest to simply RESEND the pull request with 
the proper URL and a note why you resend.

Sebastian

>
> for you to fetch changes up to d4b0833a65e8b9fc58d992ba0cc89cad1580db31:
>
>   ARM: mvebu: Fix pinctrl configuration for Armada 370 DB (2014-12-21 
>   06:01:05 -0600)
>
> ----------------------------------------------------------------
> Fixes for 3.19
>
> ----------------------------------------------------------------
> Gregory CLEMENT (1):
>       ARM: mvebu: Fix pinctrl configuration for Armada 370 DB
>
>  arch/arm/boot/dts/armada-370-db.dts | 24 ------------------------
>  1 file changed, 24 deletions(-)
