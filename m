From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 2 May 2012 14:36:02 +0200
Subject: [PATCH 05/15] ARM: imx: use machine specific hook for late init
In-Reply-To: <1335958420-5193-6-git-send-email-shawn.guo@linaro.org>
References: <1335958420-5193-1-git-send-email-shawn.guo@linaro.org>
 <1335958420-5193-6-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120502123602.GZ4141@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 02, 2012 at 07:33:30PM +0800, Shawn Guo wrote:
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/mach-imx/cpu-imx5.c            |    6 +---
>  arch/arm/mach-imx/imx51-dt.c            |    1 +
>  arch/arm/mach-imx/mach-cpuimx51.c       |    1 +
>  arch/arm/mach-imx/mach-cpuimx51sd.c     |    1 +
>  arch/arm/mach-imx/mach-mx51_3ds.c       |    1 +
>  arch/arm/mach-imx/mach-mx51_babbage.c   |    1 +
>  arch/arm/mach-imx/mach-mx51_efikamx.c   |   42 +++++++++++++++++--------------
>  arch/arm/mach-imx/mach-mx51_efikasb.c   |   28 +++++++++++---------
>  arch/arm/mach-imx/mach-pcm037.c         |    6 ++++
>  arch/arm/mach-imx/mach-pcm037_eet.c     |    5 +--
>  arch/arm/mach-imx/mm-imx5.c             |    5 +++
>  arch/arm/mach-imx/pcm037.h              |    6 ++++
>  arch/arm/plat-mxc/include/mach/common.h |    7 +++++
>  13 files changed, 71 insertions(+), 39 deletions(-)

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
