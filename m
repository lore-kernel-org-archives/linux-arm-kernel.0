From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 19 Jul 2016 08:36:00 -0600
Subject: [PATCH -next] coresight: etm4x: remove duplicated include from
 coresight-etm4x.c
In-Reply-To: <1468927641-335-1-git-send-email-weiyj_lk@163.com>
References: <1468927641-335-1-git-send-email-weiyj_lk@163.com>
Message-ID: <CANLsYkxDt2zG78AJJtn21v7GJp9wBfvsj2B5s7Vus5wo=7cZpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 July 2016 at 05:27, Wei Yongjun <weiyj_lk@163.com> wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> Remove duplicated include.
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> index 0d8ebfa..6e639b9 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -33,7 +33,6 @@
>  #include <linux/uaccess.h>
>  #include <linux/perf_event.h>
>  #include <linux/pm_runtime.h>
> -#include <linux/perf_event.h>
>  #include <asm/sections.h>
>  #include <asm/local.h>

Definitely - applied.

Thanks,
Mathieu

>
>
>
>
>
