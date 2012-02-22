From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 22 Feb 2012 23:26:19 +0100
Subject: [PATCH 1/3] arm: ignore devicetree blobs.
In-Reply-To: <3629df9b5b96d3a3a63a34ebf6ddfca2fd72ccfc.1329936660.git.jason@lakedaemon.net>
References: <cover.1312906908.git.jason@lakedaemon.net>
 <cover.1329936660.git.jason@lakedaemon.net>
 <3629df9b5b96d3a3a63a34ebf6ddfca2fd72ccfc.1329936660.git.jason@lakedaemon.net>
Message-ID: <20120222222619.GY14173@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 22, 2012 at 07:18:44PM +0000, Jason Cooper wrote:
> 
> Signed-off-by: Jason Cooper <jason@lakedaemon.net>
/me claims prior art:

	http://mid.gmane.org/1323808612-14976-1-git-send-email-u.kleine-koenig at pengutronix.de

Best regards
Uwe
	
> ---
> NOTE: This is the first version of this patch, so no change history.
> 
>  arch/arm/boot/.gitignore |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/.gitignore b/arch/arm/boot/.gitignore
> index ce1c5ff..3c79f85 100644
> --- a/arch/arm/boot/.gitignore
> +++ b/arch/arm/boot/.gitignore
> @@ -3,3 +3,4 @@ zImage
>  xipImage
>  bootpImage
>  uImage
> +*.dtb
> -- 
> 1.7.3.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
