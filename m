From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 30 Nov 2011 14:46:24 +0100
Subject: [V3 1/6] RTC: sa1100: Clean out ost register
In-Reply-To: <1322634584-4347-1-git-send-email-jtzhou@marvell.com>
References: <1322634584-4347-1-git-send-email-jtzhou@marvell.com>
Message-ID: <20111130134624.GA18533@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14:29 Wed 30 Nov     , Jett.Zhou wrote:
> These registers are used in old ioctl of UIE and PIE, now they are
> emulated by rtc generic code of hrtimer, so it can be removed.
> 
> Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
> Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
> ---
>  drivers/rtc/rtc-sa1100.c |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-sa1100.c b/drivers/rtc/rtc-sa1100.c
> index 0b40bb8..6f22c1f 100644
> --- a/drivers/rtc/rtc-sa1100.c
> +++ b/drivers/rtc/rtc-sa1100.c
> @@ -36,7 +36,6 @@
>  
>  #ifdef CONFIG_ARCH_PXA
>  #include <mach/regs-rtc.h>
please move this to include/linux too
to allow  the simgle zImage

Best Regards,
J.
