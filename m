From: olof@lixom.net (Olof Johansson)
Date: Fri, 14 Jun 2013 17:02:15 -0700
Subject: [GIT PULL 3/5]: ux500 pinctrl changes for v3.11
In-Reply-To: <CACRpkdbFs=pX+Yc8EzgVyi-k5HypkHO9jMGMU+VkYfRYyinDSA@mail.gmail.com>
References: <CACRpkdbFs=pX+Yc8EzgVyi-k5HypkHO9jMGMU+VkYfRYyinDSA@mail.gmail.com>
Message-ID: <20130615000215.GD18124@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 04, 2013 at 02:25:39PM +0200, Linus Walleij wrote:
> Hi ARM SoC folks,
> 
> this is the ux500 pin control changes for v3.11. See the signed
> tag for details.
> 
> The following changes since commit e4aa937ec75df0eea0bee03bffa3303ad36c986b:
> 
>   Linux 3.10-rc3 (2013-05-26 16:00:47 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
> tags/ux500-pinctrl-for-arm-soc
> 
> for you to fetch changes up to 8258b187c2ba91ba1ff276fd0413f5b655824247:
> 
>   ARM: ux500: add ABx500 pinctrl tables (2013-05-31 16:30:38 +0200)
> 
> ----------------------------------------------------------------
> Ux500 pinctrl changes:
> - Updates to MSP pinctrl entry for ALSA SoC
> - ABx500 pinctrl tables
> 
> ----------------------------------------------------------------
> Fabio Baltieri (1):
>       ARM: ux500: update MSP1 pinctrl defintions
> 
> Patrice Chotard (1):
>       ARM: ux500: add ABx500 pinctrl tables
> 
>  arch/arm/mach-ux500/board-mop500-pins.c | 279 ++++++++++++++++++++++++++++++--
>  1 file changed, 268 insertions(+), 11 deletions(-)

Pulled.


-Olof
