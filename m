From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Tue, 18 Sep 2012 22:19:21 +0530
Subject: [PATCH] arch/arm/mach-davinci/board-dm646x-evm.c: Remove
 unecessary
In-Reply-To: <1347986174-30287-2-git-send-email-peter.senna@gmail.com>
References: <1347986174-30287-1-git-send-email-peter.senna@gmail.com>
 <1347986174-30287-2-git-send-email-peter.senna@gmail.com>
Message-ID: <CA+V-a8tNCjXKgfV9TtWroZ+FvFQFqmrVfczVxEmUkZt2pQL3RQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

Thanks for the patch.

On Tue, Sep 18, 2012 at 10:06 PM, Peter Senna Tschudin
<peter.senna@gmail.com> wrote:
> Found by http://coccinelle.lip6.fr/
>
The commit message 'Remove unecessary' doesn't explain
what are you trying to do.

Thanks,
--Prabhakar

> Signed-off-by: Peter Senna Tschudin <peter.senna@gmail.com>
> ---
>  arch/arm/mach-davinci/board-dm646x-evm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
> index 958679a..1ccaace 100644
> --- a/arch/arm/mach-davinci/board-dm646x-evm.c
> +++ b/arch/arm/mach-davinci/board-dm646x-evm.c
> @@ -193,7 +193,7 @@ static int evm_led_setup(struct i2c_client *client, int gpio,
>         while (ngpio--) {
>                 leds->gpio = gpio++;
>                 leds++;
> -       };
> +       }
>
>         evm_led_dev = platform_device_alloc("leds-gpio", 0);
>         platform_device_add_data(evm_led_dev, &evm_led_data,
> --
> 1.7.11.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
