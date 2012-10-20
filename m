From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Sat, 20 Oct 2012 12:29:59 +0200
Subject: [PATCH] [media] s5p-tv: remove unused including <linux/version.h>
In-Reply-To: <CAPgLHd-0c4D0cSVQBZA=bbaDvcu4yHBj_2DPPGrQMKQZxxGqBg@mail.gmail.com>
References: <CAPgLHd-0c4D0cSVQBZA=bbaDvcu4yHBj_2DPPGrQMKQZxxGqBg@mail.gmail.com>
Message-ID: <50827D27.7020000@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 10/08/2012 02:32 PM, Wei Yongjun wrote:
> From: Wei Yongjun<yongjun_wei@trendmicro.com.cn>
>
> Remove including<linux/version.h>  that don't need it.
>
> dpatch engine is used to auto generate this patch.
> (https://github.com/weiyj/dpatch)

Sorry, I have already applied similar patch:
http://patchwork.linuxtv.org/patch/15057

Thanks,
Sylwester

> Signed-off-by: Wei Yongjun<yongjun_wei@trendmicro.com.cn>
> ---
>   drivers/media/platform/s5p-tv/mixer_video.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/media/platform/s5p-tv/mixer_video.c b/drivers/media/platform/s5p-tv/mixer_video.c
> index 0c1cd89..9b52f3a 100644
> --- a/drivers/media/platform/s5p-tv/mixer_video.c
> +++ b/drivers/media/platform/s5p-tv/mixer_video.c
> @@ -19,7 +19,6 @@
>   #include<linux/videodev2.h>
>   #include<linux/mm.h>
>   #include<linux/module.h>
> -#include<linux/version.h>
>   #include<linux/timer.h>
>   #include<media/videobuf2-dma-contig.h>
