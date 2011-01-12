From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 12 Jan 2011 13:31:49 +0800
Subject: Add i.MX23/28 auart support
In-Reply-To: <1294758545-9445-1-git-send-email-s.hauer@pengutronix.de>
References: <1294758545-9445-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20110112053148.GD2888@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Tue, Jan 11, 2011 at 04:09:03PM +0100, Sascha Hauer wrote:
> The following series adds support for the auart found on i.MX23/28
> 
> Sascha Hauer (2):
>       serial: Add auart driver for i.MX23/28
>       ARM i.MXS: Add auart platform support for i.MX28
> 
>  arch/arm/mach-mxs/clock-mx28.c                  |    5 +
>  arch/arm/mach-mxs/devices-mx28.h                |    8 +
>  arch/arm/mach-mxs/devices/Kconfig               |    3 +
>  arch/arm/mach-mxs/devices/Makefile              |    1 +
>  arch/arm/mach-mxs/devices/platform-auart.c      |   54 ++
>  arch/arm/mach-mxs/include/mach/devices-common.h |   10 +
>  drivers/serial/Kconfig                          |   15 +
>  drivers/serial/Makefile                         |    1 +
>  drivers/serial/mxs-auart.c                      |  763 +++++++++++++++++++++++
>  9 files changed, 860 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-mxs/devices/platform-auart.c
>  create mode 100644 drivers/serial/mxs-auart.c
> 
> 
I just fetched the branch imx-for-2.6.38 and tried to apply the patch
set on it, but failed.  What commit should I apply against?

-- 
Regards,
Shawn
