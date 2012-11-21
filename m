From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 21 Nov 2012 18:33:55 +0800
Subject: [PATCH 195/493] pinctl: remove use of __devinit
In-Reply-To: <1353349642-3677-195-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-195-git-send-email-wfp5p@virginia.edu>
Message-ID: <CAGsJ_4yec0-vgrjbx+XBOCtvPLUQCm5Z=hShyx3Om=K4C_241w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/11/20 Bill Pemberton <wfp5p@virginia.edu>:
> CONFIG_HOTPLUG is going away as an option so __devinit is no longer
> needed.
>
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
> Cc: Barry Song <baohua.song@csr.com>
> Cc: Viresh Kumar <viresh.linux@gmail.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-rpi-kernel at lists.infradead.org
> Cc: spear-devel at list.st.com

Acked-by: Barry Song <baohua.song@csr.com>

> ---
>  drivers/pinctrl/mvebu/pinctrl-armada-370.c |  2 +-
>  drivers/pinctrl/mvebu/pinctrl-armada-xp.c  |  2 +-
>  drivers/pinctrl/mvebu/pinctrl-dove.c       |  2 +-
>  drivers/pinctrl/mvebu/pinctrl-kirkwood.c   |  2 +-
>  drivers/pinctrl/mvebu/pinctrl-mvebu.c      |  6 +++---
>  drivers/pinctrl/pinctrl-at91.c             | 16 ++++++++--------
>  drivers/pinctrl/pinctrl-bcm2835.c          |  2 +-
>  drivers/pinctrl/pinctrl-imx.c              |  8 ++++----
>  drivers/pinctrl/pinctrl-imx23.c            |  2 +-
>  drivers/pinctrl/pinctrl-imx28.c            |  2 +-
>  drivers/pinctrl/pinctrl-imx35.c            |  2 +-
>  drivers/pinctrl/pinctrl-imx51.c            |  2 +-
>  drivers/pinctrl/pinctrl-imx53.c            |  2 +-
>  drivers/pinctrl/pinctrl-imx6q.c            |  2 +-
>  drivers/pinctrl/pinctrl-mmp2.c             |  2 +-
>  drivers/pinctrl/pinctrl-mxs.c              |  6 +++---
>  drivers/pinctrl/pinctrl-nomadik-db8500.c   |  2 +-
>  drivers/pinctrl/pinctrl-nomadik-db8540.c   |  2 +-
>  drivers/pinctrl/pinctrl-nomadik-stn8815.c  |  2 +-
>  drivers/pinctrl/pinctrl-nomadik.c          |  4 ++--
>  drivers/pinctrl/pinctrl-pxa168.c           |  2 +-
>  drivers/pinctrl/pinctrl-pxa910.c           |  2 +-
>  drivers/pinctrl/pinctrl-samsung.c          | 12 ++++++------
>  drivers/pinctrl/pinctrl-single.c           |  6 +++---
>  drivers/pinctrl/pinctrl-sirf.c             |  4 ++--
>  drivers/pinctrl/pinctrl-tegra.c            |  2 +-
>  drivers/pinctrl/pinctrl-tegra20.c          |  2 +-
>  drivers/pinctrl/pinctrl-tegra30.c          |  2 +-
>  drivers/pinctrl/pinctrl-u300.c             |  2 +-
>  drivers/pinctrl/pinctrl-xway.c             |  2 +-
>  drivers/pinctrl/spear/pinctrl-plgpio.c     |  4 ++--
>  drivers/pinctrl/spear/pinctrl-spear.c      |  6 +++---
>  drivers/pinctrl/spear/pinctrl-spear.h      |  6 +++---
>  drivers/pinctrl/spear/pinctrl-spear1310.c  |  2 +-
>  drivers/pinctrl/spear/pinctrl-spear1340.c  |  2 +-
>  drivers/pinctrl/spear/pinctrl-spear300.c   |  2 +-
>  drivers/pinctrl/spear/pinctrl-spear310.c   |  2 +-
>  drivers/pinctrl/spear/pinctrl-spear320.c   |  2 +-
>  38 files changed, 66 insertions(+), 66 deletions(-)
