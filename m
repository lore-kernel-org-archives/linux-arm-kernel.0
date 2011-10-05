From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 5 Oct 2011 10:39:38 -0600
Subject: [PATCH 11/16] spi: pl022: Enable module alias autogeneration for
	AMBA drivers
In-Reply-To: <1317830707-17517-12-git-send-email-dave.martin@linaro.org>
References: <1317830707-17517-1-git-send-email-dave.martin@linaro.org>
	<1317830707-17517-12-git-send-email-dave.martin@linaro.org>
Message-ID: <CACxGe6tj3ZiLiHQjbRecymTLe6HhnF9=SBZj4_Fez8hZ1ekR9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 5, 2011 at 10:05 AM, Dave Martin <dave.martin@linaro.org> wrote:
> Signed-off-by: Dave Martin <dave.martin@linaro.org>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> ?drivers/spi/spi-pl022.c | ? ?2 ++
> ?1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
> index f103e470..43abaf2 100644
> --- a/drivers/spi/spi-pl022.c
> +++ b/drivers/spi/spi-pl022.c
> @@ -2424,6 +2424,8 @@ static struct amba_id pl022_ids[] = {
> ? ? ? ?{ 0, 0 },
> ?};
>
> +MODULE_DEVICE_TABLE(amba, pl022_ids);
> +
> ?static struct amba_driver pl022_driver = {
> ? ? ? ?.drv = {
> ? ? ? ? ? ? ? ?.name ? = "ssp-pl022",
> --
> 1.7.4.1
>
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
