From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 11 Sep 2018 13:39:07 +0100
Subject: [PATCH v4 1/5] mfd: rk808: Add RK817 and RK809 support
In-Reply-To: <1535968829-19418-2-git-send-email-tony.xie@rock-chips.com>
References: <1535968829-19418-1-git-send-email-tony.xie@rock-chips.com>
 <1535968829-19418-2-git-send-email-tony.xie@rock-chips.com>
Message-ID: <20180911123907.GN4185@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 03 Sep 2018, Tony Xie wrote:

>     The rk809 and rk817 are a Power Management IC (PMIC) for multimedia
>     and handheld devices. It contains the following components:
> 
>         - Regulators
>         - RTC
>         - Clocking
> 
>     Both RK809 and RK817 chips are using a similar register map,
>     so we can reuse the RTC and Clocking and regulators functionality.
> 
> Signed-off-by: Tony Xie <tony.xie@rock-chips.com>
> ---

It's often helpful to place a Changelog in this space.

>  drivers/mfd/Kconfig       |   6 +-
>  drivers/mfd/rk808.c       | 218 +++++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/mfd/rk808.h | 172 ++++++++++++++++++++++++++++++++++++
>  kernel/reboot.c           |   1 +
>  4 files changed, 391 insertions(+), 6 deletions(-)

I just reviewed v4.

It looks like the review comments are still relevant.

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
