From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Thu, 6 Oct 2011 10:47:36 +0530
Subject: [PATCH 05/16] dmaengine: pl330: Enable module alias
	autogeneration for AMBA drivers
In-Reply-To: <1317830707-17517-6-git-send-email-dave.martin@linaro.org>
References: <1317830707-17517-1-git-send-email-dave.martin@linaro.org>
	<1317830707-17517-6-git-send-email-dave.martin@linaro.org>
Message-ID: <CAJe_ZhePtDRD-Ov4D9jrEY7jt97aX9cM+jA0-=gkC1nZadRcMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 October 2011 21:34, Dave Martin <dave.martin@linaro.org> wrote:
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> ---
> ?drivers/dma/pl330.c | ? ?2 ++
> ?1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> index 57104147..2d8d1b0 100644
> --- a/drivers/dma/pl330.c
> +++ b/drivers/dma/pl330.c
> @@ -990,6 +990,8 @@ static struct amba_id pl330_ids[] = {
> ? ? ? ?{ 0, 0 },
> ?};
>
> +MODULE_DEVICE_TABLE(amba, pl330_ids);
> +
> ?#ifdef CONFIG_PM_RUNTIME
> ?static int pl330_runtime_suspend(struct device *dev)
> ?{

Acked-by: Jassi Brar <jassisinghbrar@gmail.com>

Thanks.
