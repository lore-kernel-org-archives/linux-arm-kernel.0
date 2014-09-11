From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 11 Sep 2014 10:49:41 +0530
Subject: [PATCH 2/2] ASoC: mmp-pcm: add NO_PERIOD_WAKEUP for PCM INFO
In-Reply-To: <1410338449-13961-2-git-send-email-zhouqiao@marvell.com>
References: <1410338449-13961-1-git-send-email-zhouqiao@marvell.com>
 <1410338449-13961-2-git-send-email-zhouqiao@marvell.com>
Message-ID: <20140911051941.GE3131@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 10, 2014 at 04:40:49PM +0800, Qiao Zhou wrote:
> add NO_PERIOD_WAKEUP to PCM INFO, which supports audio no IRQ mode

Applied, thanks

-- 
~Vinod

> 
> Signed-off-by: Qiao Zhou <zhouqiao@marvell.com>
> ---
>  sound/soc/pxa/mmp-pcm.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/pxa/mmp-pcm.c b/sound/soc/pxa/mmp-pcm.c
> index 5e8d813..64e8b94 100644
> --- a/sound/soc/pxa/mmp-pcm.c
> +++ b/sound/soc/pxa/mmp-pcm.c
> @@ -34,7 +34,8 @@ struct mmp_dma_data {
>  		SNDRV_PCM_INFO_MMAP_VALID |	\
>  		SNDRV_PCM_INFO_INTERLEAVED |	\
>  		SNDRV_PCM_INFO_PAUSE |		\
> -		SNDRV_PCM_INFO_RESUME)
> +		SNDRV_PCM_INFO_RESUME |		\
> +		SNDRV_PCM_INFO_NO_PERIOD_WAKEUP)
>  
>  static struct snd_pcm_hardware mmp_pcm_hardware[] = {
>  	{
> -- 
> 1.7.0.4
> 

-- 
