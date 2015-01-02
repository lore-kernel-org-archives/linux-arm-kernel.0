From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 2 Jan 2015 08:09:23 -0700
Subject: [PATCH] coresight: fix typo in comment in of_coresight.c
In-Reply-To: <1420011629-77676-1-git-send-email-xiakaixu@huawei.com>
References: <1420011629-77676-1-git-send-email-xiakaixu@huawei.com>
Message-ID: <CANLsYkxhd=shvkDBzJEzDk4a-AzcjBemp8VatHi33n8d7JB2Lg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 December 2014 at 00:40, Kaixu Xia <xiakaixu@huawei.com> wrote:
> Debugfs isn't used for coresight configuration, so the corresponding
> comments should be changed.
>
> Signed-off-by: Kaixu Xia <xiakaixu@huawei.com>
> ---
>  drivers/coresight/of_coresight.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/coresight/of_coresight.c b/drivers/coresight/of_coresight.c
> index 5030c07..8bd524e 100644
> --- a/drivers/coresight/of_coresight.c
> +++ b/drivers/coresight/of_coresight.c
> @@ -126,7 +126,7 @@ struct coresight_platform_data *of_get_coresight_platform_data(
>         if (!pdata)
>                 return ERR_PTR(-ENOMEM);
>
> -       /* Use device name as debugfs handle */
> +       /* Use device name as sysfs handle */
>         pdata->name = dev_name(dev);
>
>         /* Get the number of input and output port for this component */
> --
> 1.8.5.5
>

Applied - thanks.
