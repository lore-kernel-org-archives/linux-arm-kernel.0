From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 8 Sep 2011 21:42:12 -0300
Subject: [PATCH] ARM: imx: move pwm driver to use platform device id table
In-Reply-To: <1315524142-10566-1-git-send-email-eric.miao@linaro.org>
References: <1315524142-10566-1-git-send-email-eric.miao@linaro.org>
Message-ID: <CAOMZO5AybMLPK2Q8RrE9cAemHjGgsz-+Z0-VCtOB5t=rxFrN4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 8, 2011 at 8:22 PM, Eric Miao <eric.miao@linaro.org> wrote:
> Signed-off-by: Eric Miao <eric.miao@linaro.org>
> ---
> ?arch/arm/mach-imx/clock-imx25.c ? ? ? ? ? ? ?| ? ?8 ++++----
> ?arch/arm/mach-imx/clock-imx27.c ? ? ? ? ? ? ?| ? ?2 +-
> ?arch/arm/mach-imx/devices-imx25.h ? ? ? ? ? ?| ? ?2 +-
> ?arch/arm/mach-mx5/clock-mx51-mx53.c ? ? ? ? ?| ? ?4 ++--
> ?arch/arm/mach-mx5/devices-imx51.h ? ? ? ? ? ?| ? ?2 +-
> ?arch/arm/plat-mxc/devices/platform-mxc_pwm.c | ? ?4 ++--
> ?arch/arm/plat-mxc/pwm.c ? ? ? ? ? ? ? ? ? ? ?| ? 19 ++++++++++++++++---
> ?7 files changed, 27 insertions(+), 14 deletions(-)

Looks like you missed mx1, mx21, mx31, mx27, mx35 and mx53.
