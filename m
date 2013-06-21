From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Jun 2013 15:41:56 +0200
Subject: [GIT PULL] ARM: bcm281xx cleanups  for 3.11
In-Reply-To: <51C383FC.3000601@broadcom.com>
References: <51C383FC.3000601@broadcom.com>
Message-ID: <201306211541.56888.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 June 2013, Christian Daudt wrote:
> Hi Arnd, Olof,
>   Please pull the branch below. It contains init_irq related cleanups.
> 
>   Thanks,
>     csd
> 
> The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:
> 
>    Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)
> 
> are available in the git repository at:
> 
>    git://github.com/broadcom/bcm11351.git armsoc/for-3.11/cleanups
> 
> for you to fetch changes up to 77979bd7b514680a7c9c6efcb01e0b535985e36e:
> 
>    ARM: bcm281xx: Remove init_irq declaration in machine description 
> (2013-05-14 09:48:40 -0700)
> 
> ----------------------------------------------------------------
> Misc cleanups for 3.11
> 
> ----------------------------------------------------------------
> Maxime Ripard (1):
>        ARM: bcm281xx: Remove init_irq declaration in machine description
> 
>   arch/arm/mach-bcm/board_bcm.c |    2 --
>   1 file changed, 2 deletions(-)

Pulled into next/cleanup, thanks!

	Arnd
