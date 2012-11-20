From: viresh.kumar@linaro.org (viresh kumar)
Date: Tue, 20 Nov 2012 08:38:40 +0530
Subject: [PATCH 195/493] pinctl: remove use of __devinit
In-Reply-To: <1353349642-3677-195-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-195-git-send-email-wfp5p@virginia.edu>
Message-ID: <CAOh2x==y+pdM_CEoBxFNVSEoLF=Y1uM8zdXZeTU0=wNBj5=NcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 11:52 PM, Bill Pemberton <wfp5p@virginia.edu> wrote:
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
> ---
>  drivers/pinctrl/spear/pinctrl-plgpio.c     |  4 ++--
>  drivers/pinctrl/spear/pinctrl-spear.c      |  6 +++---
>  drivers/pinctrl/spear/pinctrl-spear.h      |  6 +++---
>  drivers/pinctrl/spear/pinctrl-spear1310.c  |  2 +-
>  drivers/pinctrl/spear/pinctrl-spear1340.c  |  2 +-
>  drivers/pinctrl/spear/pinctrl-spear300.c   |  2 +-
>  drivers/pinctrl/spear/pinctrl-spear310.c   |  2 +-
>  drivers/pinctrl/spear/pinctrl-spear320.c   |  2 +-

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
