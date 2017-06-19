From: olof@lixom.net (Olof Johansson)
Date: Sun, 18 Jun 2017 22:38:44 -0700
Subject: [GIT PULL] ARM: at91: defconfig for 4.13
In-Reply-To: <20170616131643.3aebid7p33x7aott@piout.net>
References: <20170616131643.3aebid7p33x7aott@piout.net>
Message-ID: <20170619053844.GF7703@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 16, 2017 at 03:16:43PM +0200, Alexandre Belloni wrote:
> Arnd, Olof,
> 
> A few defconfig updates for 4.13
> 
> The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:
> 
>   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.13-defconfig
> 
> for you to fetch changes up to 0f286c4cb620c18206659d9ee91cf0f51d8839b6:
> 
>   ARM: configs: at91: add MCAN driver to sama5_defconfig (2017-05-15 12:18:56 +0200)
> 
> ----------------------------------------------------------------
> defconfig for 4.13:
> 
>  - Switch sama5 to be tickless in idle and enable hrtimer
>  - Add MCAN
> 
> ----------------------------------------------------------------
> Quentin Schulz (2):
>       ARM: configs: at91: make system tickless when idle
>       ARM: configs: at91: enable HIGH_RES_TIMERS
> 
> Wenyou Yang (1):
>       ARM: configs: at91: add MCAN driver to sama5_defconfig

Merged, thanks.


-Olof
