From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 23 Jan 2013 08:07:52 -0500
Subject: [PATCH v2] cpuidle: kirkwood: Move out of mach directory
In-Reply-To: <1357734135-3985-1-git-send-email-andrew@lunn.ch>
References: <1357734135-3985-1-git-send-email-andrew@lunn.ch>
Message-ID: <20130123130752.GI1758@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 09, 2013 at 01:22:15PM +0100, Andrew Lunn wrote:
> Move the Kirkwood cpuidle driver out of arch/arm/mach-kirkwood and
> into drivers/cpuidle. Convert the driver into a platform driver.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/configs/kirkwood_defconfig            |    1 +
>  arch/arm/mach-kirkwood/Makefile                |    1 -
>  arch/arm/mach-kirkwood/board-dt.c              |    2 +
>  arch/arm/mach-kirkwood/common.c                |   23 +++++
>  arch/arm/mach-kirkwood/common.h                |    1 +
>  arch/arm/mach-kirkwood/cpuidle.c               |   73 ----------------
>  arch/arm/mach-kirkwood/include/mach/kirkwood.h |    3 +-
>  drivers/cpuidle/Kconfig                        |    6 ++
>  drivers/cpuidle/Makefile                       |    1 +
>  drivers/cpuidle/cpuidle-kirkwood.c             |  106 ++++++++++++++++++++++++
>  10 files changed, 142 insertions(+), 75 deletions(-)
>  delete mode 100644 arch/arm/mach-kirkwood/cpuidle.c
>  create mode 100644 drivers/cpuidle/cpuidle-kirkwood.c

Applied to mvebu/drivers

thx,

Jason.
