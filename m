From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 15 Dec 2011 10:25:54 +0800
Subject: [PATCH] ARM: add device tree blobs to .gitignore
In-Reply-To: <1323808612-14976-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1323808612-14976-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20111215022553.GE3259@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2011 at 09:36:52PM +0100, Uwe Kleine-K?nig wrote:
> *.dtb files are a build result and so should be ignored.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---

Acked-by: Shawn Guo <shawn.guo@linaro.org>

-- 
Regards,
Shawn

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
> 1.7.7.3
