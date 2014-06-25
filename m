From: spk.linux@gmail.com (Sachin Kamat)
Date: Wed, 25 Jun 2014 16:19:32 +0530
Subject: [PATCH 2/2] i2c: exynos5: fix minor styling nits
In-Reply-To: <1403692697-7381-2-git-send-email-ch.naveen@samsung.com>
References: <1403692697-7381-1-git-send-email-ch.naveen@samsung.com>
 <1403692697-7381-2-git-send-email-ch.naveen@samsung.com>
Message-ID: <CAK5sBcEVHYQutEm9Lh3eGX8_6zKLV-m3XfYKtnfPs8CBExpHqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Naveen,

On Wed, Jun 25, 2014 at 4:08 PM, Naveen Krishna Chatradhi
<ch.naveen@samsung.com> wrote:
> This patch removes an extra line and fixes a styling nit
> in exynos5_i2c_message_start()
>
> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> ---
>  drivers/i2c/busses/i2c-exynos5.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-exynos5.c b/drivers/i2c/busses/i2c-exynos5.c
> index 0d1a7bc..4c2e6f3 100644
> --- a/drivers/i2c/busses/i2c-exynos5.c
> +++ b/drivers/i2c/busses/i2c-exynos5.c
> @@ -525,7 +525,7 @@ static void exynos5_i2c_message_start(struct exynos5_i2c *i2c, int stop)
>         if (i2c->msg->flags & I2C_M_RD) {
>                 i2c_ctl |= HSI2C_RXCHON;
>
> -               i2c_auto_conf = HSI2C_READ_WRITE;
> +               i2c_auto_conf |= HSI2C_READ_WRITE;

This change looks more than just a styling nit. Please update the commit message
accordingly.

-- 
Regards,
Sachin.
