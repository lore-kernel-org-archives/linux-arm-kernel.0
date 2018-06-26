From: niklas.cassel@linaro.org (Niklas Cassel)
Date: Tue, 26 Jun 2018 11:36:41 +0200
Subject: [PATCH v2 12/12] ASoC: qdsp6: q6asm: remove unused struct q6asm
 member
In-Reply-To: <20180626092016.9296-13-srinivas.kandagatla@linaro.org>
References: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
 <20180626092016.9296-13-srinivas.kandagatla@linaro.org>
Message-ID: <20180626093641.GH25217@centauri.ideon.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Niklas Cassel <niklas.cassel@linaro.org>

On Tue, Jun 26, 2018 at 10:20:16AM +0100, Srinivas Kandagatla wrote:
> pcmdev in struct q6asm seems be left over and unused, so just remove it.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/qcom/qdsp6/q6asm.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
> index c4fd28f168d5..2b2c7233bb5f 100644
> --- a/sound/soc/qcom/qdsp6/q6asm.c
> +++ b/sound/soc/qcom/qdsp6/q6asm.c
> @@ -174,7 +174,6 @@ struct q6asm {
>  	struct device *dev;
>  	struct q6core_svc_api_info ainfo;
>  	wait_queue_head_t mem_wait;
> -	struct platform_device *pcmdev;
>  	spinlock_t slock;
>  	struct audio_client *session[MAX_SESSIONS + 1];
>  };
> -- 
> 2.16.2
> 
