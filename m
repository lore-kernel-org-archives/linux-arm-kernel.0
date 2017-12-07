From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 7 Dec 2017 09:40:30 -0700
Subject: [PATCH 05/45] drivers: hwtracing: remove duplicate includes
In-Reply-To: <1512439209-15661-1-git-send-email-pravin.shedge4linux@gmail.com>
References: <1512439209-15661-1-git-send-email-pravin.shedge4linux@gmail.com>
Message-ID: <CANLsYkzLk3O4LeA7vnWus9rTtNP7uVRBO3YwvLoaHMuBNidSpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 December 2017 at 19:00, Pravin Shedge
<pravin.shedge4linux@gmail.com> wrote:
> These duplicate includes have been found with scripts/checkincludes.pl but
> they have been removed manually to avoid removing false positives.
>
> Signed-off-by: Pravin Shedge <pravin.shedge4linux@gmail.com>
> ---
>  drivers/hwtracing/coresight/coresight-etb10.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
> index e03e589..580cd38 100644
> --- a/drivers/hwtracing/coresight/coresight-etb10.c
> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
> @@ -33,7 +33,6 @@
>  #include <linux/mm.h>
>  #include <linux/perf_event.h>
>
> -#include <asm/local.h>
>
>  #include "coresight-priv.h"

Applied with a reworked commit header.
Mathieu



>
> --
> 2.7.4
>
