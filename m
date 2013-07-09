From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Tue, 9 Jul 2013 07:24:05 +0200
Subject: [PATCH 0/2] Optimize L2 setting on imx6sl
In-Reply-To: <1373293383-15128-1-git-send-email-shawn.guo@linaro.org>
References: <1373293383-15128-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <51DB9E75.7030008@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.07.2013 16:23, Shawn Guo wrote:
> The series leverages the L2 optimization done on imx6q/dl for imx6sl,
> by moving imx6q_init_l2cache() out from mach-imx6q.c into system.c and
> renaming it imx_init_l2cache().
>
> Shawn Guo (2):
>    ARM: imx: let L2 initialization be a common function
>    ARM: imx: use imx specific L2 init function on imx6sl
>
>   arch/arm/mach-imx/common.h      |    6 ++++++
>   arch/arm/mach-imx/mach-imx6q.c  |   37 +------------------------------------
>   arch/arm/mach-imx/mach-imx6sl.c |    3 +--
>   arch/arm/mach-imx/system.c      |   33 +++++++++++++++++++++++++++++++++
>   4 files changed, 41 insertions(+), 38 deletions(-)

Whole series:

Acked-by: Dirk Behme <dirk.behme@de.bosch.com>

Thanks

Dirk
