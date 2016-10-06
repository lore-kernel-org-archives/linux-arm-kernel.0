From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 6 Oct 2016 10:04:49 -0600
Subject: [PATCH] indentation fix (extra space removed)
In-Reply-To: <0b897b22-fc32-c97e-b678-1c0040782a62@centralesupelec.fr>
References: <0b897b22-fc32-c97e-b678-1c0040782a62@centralesupelec.fr>
Message-ID: <CANLsYkzs+oy1f6j8sBg29Dc4kmcQ1ZEwQ18j_wDbrPVv9WjN-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 October 2016 at 05:41, Muhammad Abdul WAHAB
<muhammadabdul.wahab@centralesupelec.fr> wrote:
> An extra space is removed.
>
> Signed-off-by: Muhammad Abdul Wahab <muhammadabdul.wahab@centralesupelec.fr>
> ---
>  drivers/hwtracing/coresight/coresight-etm3x-sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> index e9b0719..5ea0909 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> @@ -146,7 +146,7 @@ static ssize_t mode_store(struct device *dev,
>                         goto err_unlock;
>                 }
>                 config->ctrl |= ETMCR_STALL_MODE;
> -        } else
> +       } else
>                 config->ctrl &= ~ETMCR_STALL_MODE;
>
>         if (config->mode & ETM_MODE_TIMESTAMP) {

Applied, but prepended "coresight: etm3x:" to the original title.

Thanks,
Mathieu

> --
> 1.9.1
