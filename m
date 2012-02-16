From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 16 Feb 2012 10:34:48 +0800
Subject: [PATCH] arch/arm/mach-pxa/pxa27x.c: included linux/gpio.h twice
In-Reply-To: <1329333565-31718-1-git-send-email-danny.kukawka@bisect.de>
References: <1329333565-31718-1-git-send-email-danny.kukawka@bisect.de>
Message-ID: <CAN1soZyuqMHAsTU2Yjj=uxPREzqrTTxMpwgc3_wkvd6nVbfssw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2012 at 3:19 AM, Danny Kukawka <danny.kukawka@bisect.de> wrote:
> arch/arm/mach-pxa/pxa27x.c included 'linux/gpio.h' twice, remove
> the duplicate.
>
> Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>
> ---
> ?arch/arm/mach-pxa/pxa27x.c | ? ?1 -
> ?1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
> index aed6cbc..c1673b3 100644
> --- a/arch/arm/mach-pxa/pxa27x.c
> +++ b/arch/arm/mach-pxa/pxa27x.c
> @@ -22,7 +22,6 @@
> ?#include <linux/io.h>
> ?#include <linux/irq.h>
> ?#include <linux/i2c/pxa-i2c.h>
> -#include <linux/gpio.h>
>
> ?#include <asm/mach/map.h>
> ?#include <mach/hardware.h>
> --
> 1.7.8.3
>
Applied.

Thanks
Haojian
