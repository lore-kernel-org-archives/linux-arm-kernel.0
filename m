From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 28 Nov 2018 09:30:22 -0700
Subject: [PATCH] coresight: fix spelling mistake "deffered" -> "deferred"
In-Reply-To: <20181127140356.26626-1-colin.king@canonical.com>
References: <20181127140356.26626-1-colin.king@canonical.com>
Message-ID: <CANLsYkzyHiD0NXn6jOpJg7Ho3G83dqTX9N-8BsNUtxNRiXS3Fw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 27 Nov 2018 at 07:03, Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in the dev_info error message, fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/hwtracing/coresight/coresight-stm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
> index 35d6f9709274..ef339ff22090 100644
> --- a/drivers/hwtracing/coresight/coresight-stm.c
> +++ b/drivers/hwtracing/coresight/coresight-stm.c
> @@ -856,7 +856,7 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
>
>         if (stm_register_device(dev, &drvdata->stm, THIS_MODULE)) {
>                 dev_info(dev,
> -                        "stm_register_device failed, probing deffered\n");
> +                        "stm_register_device failed, probing deferred\n");
>                 return -EPROBE_DEFER;
>         }
>

Applied - thanks,
Mathieu

> --
> 2.19.1
>
