From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 20 Oct 2010 14:03:53 +0800
Subject: [PATCH 3/5] rtc-pxa: remove unused TIMER_FREQ define
In-Reply-To: <20101020045141.GZ12979@mail.wantstofly.org>
References: <20101020045141.GZ12979@mail.wantstofly.org>
Message-ID: <AANLkTikMskk+60Bj8pAav2kh6PZKGJ7o4HipDRobpLhN@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 20, 2010 at 12:51 PM, Lennert Buytenhek
<buytenh@wantstofly.org> wrote:
> Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>

Acked-by: Eric Miao <eric.miao@canonical.com>

> ---
> ?drivers/rtc/rtc-pxa.c | ? ?1 -
> ?1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/rtc/rtc-pxa.c b/drivers/rtc/rtc-pxa.c
> index 29e867a..486b72d 100644
> --- a/drivers/rtc/rtc-pxa.c
> +++ b/drivers/rtc/rtc-pxa.c
> @@ -30,7 +30,6 @@
>
> ?#include <mach/hardware.h>
>
> -#define TIMER_FREQ ? ? ? ? ? ? CLOCK_TICK_RATE
> ?#define RTC_DEF_DIVIDER ? ? ? ? ? ? ? ?(32768 - 1)
> ?#define RTC_DEF_TRIM ? ? ? ? ? 0
> ?#define MAXFREQ_PERIODIC ? ? ? 1000
> --
> 1.7.2.3
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
