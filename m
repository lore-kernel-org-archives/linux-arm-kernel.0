From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 17 Jun 2013 10:05:59 +0800
Subject: [PATCH] ARM: imx: Add RTC support for i.MX27
In-Reply-To: <1371310866-6136-1-git-send-email-shc_work@mail.ru>
References: <1371310866-6136-1-git-send-email-shc_work@mail.ru>
Message-ID: <20130617020557.GB31687@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 15, 2013 at 07:41:06PM +0400, Alexander Shiyan wrote:
> This patch adds support using i.MX27 On-Chip RTC from board files.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/mach-imx/devices-imx27.h            |  4 ++++
>  arch/arm/mach-imx/devices/devices-common.h   |  1 +
>  arch/arm/mach-imx/devices/platform-mxc_rtc.c | 14 ++++++++++----
>  3 files changed, 15 insertions(+), 4 deletions(-)

Sorry.  I'm not taking it since we're not taking any board file patches
anyway.

Shawn
