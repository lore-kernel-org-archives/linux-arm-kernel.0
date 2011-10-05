From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 5 Oct 2011 10:39:04 -0600
Subject: [PATCH 06/16] gpio: pl061: Enable module alias autogeneration for
	AMBA drivers
In-Reply-To: <1317830707-17517-7-git-send-email-dave.martin@linaro.org>
References: <1317830707-17517-1-git-send-email-dave.martin@linaro.org>
	<1317830707-17517-7-git-send-email-dave.martin@linaro.org>
Message-ID: <CACxGe6tnDXjFo5vS3rea1WuTm6WJo=ZNraELmPiz5Eqk-QukoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 5, 2011 at 10:04 AM, Dave Martin <dave.martin@linaro.org> wrote:
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
Acked-by: Grant Likely <grant.likely@secretlab.ca>

Feel free to take this through the same tree that the rest of the
patches go through.

g.

> ---
> ?drivers/gpio/gpio-pl061.c | ? ?2 ++
> ?1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/gpio/gpio-pl061.c b/drivers/gpio/gpio-pl061.c
> index 2c5a18f..503e9d5 100644
> --- a/drivers/gpio/gpio-pl061.c
> +++ b/drivers/gpio/gpio-pl061.c
> @@ -339,6 +339,8 @@ static struct amba_id pl061_ids[] = {
> ? ? ? ?{ 0, 0 },
> ?};
>
> +MODULE_DEVICE_TABLE(amba, pl061_ids);
> +
> ?static struct amba_driver pl061_gpio_driver = {
> ? ? ? ?.drv = {
> ? ? ? ? ? ? ? ?.name ? = "pl061_gpio",
> --
> 1.7.4.1
>
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
