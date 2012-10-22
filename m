From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 21 Oct 2012 23:09:01 -0400
Subject: [PATCH v2 1/3] ARM: Kirkwood: Remove unused includes
In-Reply-To: <1350732196-26781-1-git-send-email-andrew@lunn.ch>
References: <1350732196-26781-1-git-send-email-andrew@lunn.ch>
Message-ID: <20121022030901.GJ25828@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 20, 2012 at 01:23:14PM +0200, Andrew Lunn wrote:
> With the gradual conversion of C code to DT, there are a number of
> include files which are no longer needed. Remove them.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/mach-kirkwood/board-dockstar.c       |   13 -------------
>  arch/arm/mach-kirkwood/board-dreamplug.c      |   15 ---------------
>  arch/arm/mach-kirkwood/board-goflexnet.c      |   13 -------------
>  arch/arm/mach-kirkwood/board-ib62x0.c         |    6 ------
>  arch/arm/mach-kirkwood/board-iconnect.c       |    8 --------
>  arch/arm/mach-kirkwood/board-iomega_ix2_200.c |    2 --
>  arch/arm/mach-kirkwood/board-lsxl.c           |    8 --------
>  arch/arm/mach-kirkwood/board-ts219.c          |    3 ---
>  8 files changed, 68 deletions(-)

Whole series applied to:

git://git.infradead.org/users/jcooper/linux.git kirkwood/cleanup

thx,

Jason.
