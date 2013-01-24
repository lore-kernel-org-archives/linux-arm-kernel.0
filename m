From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 24 Jan 2013 11:23:30 +0100
Subject: [PATCH v3 0/8] ARM: shmobile: pinctrl and DT extensions
In-Reply-To: <1358959071-2873-1-git-send-email-g.liakhovetski@gmx.de>
References: <1358959071-2873-1-git-send-email-g.liakhovetski@gmx.de>
Message-ID: <3408465.uPKvaWnlNI@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guennadi,

Thanks for the patches.

For the whole set,

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

On Wednesday 23 January 2013 17:37:43 Guennadi Liakhovetski wrote:
> This is v3 of the patch series [1], addressing minor issues in 3 out of 8
> patches.
> 
> [1] http://thread.gmane.org/gmane.linux.ports.sh.devel/18729
> 
> Guennadi Liakhovetski (8):
>   pinctrl: add SDHI and MMCIF pin groups to r8a7740
>   pinctrl: add SDHI and MMCIF pin groups to sh7372
>   ARM: shmobile: simplify armadillo800eva and kzm9g Kconfig
>     dependencies
>   ARM: shmobile: add MMCIF and SDHI DT clock aliases to sh73a0 and
>     r8a7740
>   ARM: shmobile: add a GPIO controller DT node for sh7372
>   ARM: shmobile: use GPIO SD-card detection on armadillo800eva
>   ARM: shmobile: completely switch MMC interfaces on mackerel-reference
>     to DT
>   ARM: shmobile: completely switch MMC interfaces on
>     armadillo800eva-reference to DT
> 
>  .../boot/dts/r8a7740-armadillo800eva-reference.dts |  107 +++++++++
>  arch/arm/boot/dts/sh7372-mackerel-reference.dts    |   42 +++-
>  arch/arm/boot/dts/sh7372.dtsi                      |    8 +
>  arch/arm/mach-shmobile/Kconfig                     |   12 +-
>  .../board-armadillo800eva-reference.c              |    5 +-
>  arch/arm/mach-shmobile/board-armadillo800eva.c     |   10 +-
>  arch/arm/mach-shmobile/board-mackerel-reference.c  |   46 ----
>  arch/arm/mach-shmobile/clock-r8a7740.c             |    4 +
>  arch/arm/mach-shmobile/clock-sh73a0.c              |    3 +
>  drivers/pinctrl/sh-pfc/pfc-r8a7740.c               |  248 +++++++++++++++++
>  drivers/pinctrl/sh-pfc/pfc-sh7372.c                |  205 ++++++++++++++++
>  11 files changed, 626 insertions(+), 64 deletions(-)

-- 
Regards,

Laurent Pinchart
