From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 27 May 2010 09:57:54 +0100
Subject: [PATCH] s3c2410_ts: restore s3c24xx ids
In-Reply-To: <1274940997-23706-1-git-send-email-anarsoul@gmail.com>
References: <1274940997-23706-1-git-send-email-anarsoul@gmail.com>
Message-ID: <20100527085754.GL4720@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 27, 2010 at 09:16:37AM +0300, Vasily Khoruzhick wrote:
> Without s3c24xx ids driver doesn't attach on s3c2410 and s3c244x

should have spotted this in the first place, either please send to
Dimitry and the input list with my ack.
 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  drivers/input/touchscreen/s3c2410_ts.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/s3c2410_ts.c b/drivers/input/touchscreen/s3c2410_ts.c
> index e0b7c83..ac5d0f9 100644
> --- a/drivers/input/touchscreen/s3c2410_ts.c
> +++ b/drivers/input/touchscreen/s3c2410_ts.c
> @@ -413,6 +413,8 @@ static struct dev_pm_ops s3c_ts_pmops = {
>  #endif
>  
>  static struct platform_device_id s3cts_driver_ids[] = {
> +	{ "s3c2410-ts", 0 },
> +	{ "s3c2440-ts", 0 },
>  	{ "s3c64xx-ts", FEAT_PEN_IRQ },
>  	{ }
>  };
> -- 
> 1.7.1
> 

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
