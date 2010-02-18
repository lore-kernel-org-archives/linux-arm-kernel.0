From: jassisinghbrar@gmail.com (jassi brar)
Date: Thu, 18 Feb 2010 10:07:53 +0900
Subject: [PATCH 2/2] ARM: SMDK6410: Register IISv4 device
In-Reply-To: <1266433400-26780-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1266433400-26780-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1266433400-26780-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1b68c6791002171707r71bfee5ev5bea8daa7537a975@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 18, 2010 at 4:03 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> diff --git a/arch/arm/mach-s3c6410/mach-smdk6410.c b/arch/arm/mach-s3c6410/mach-smdk6410.c
> index 297f1fa..6176243 100644
> --- a/arch/arm/mach-s3c6410/mach-smdk6410.c
> +++ b/arch/arm/mach-s3c6410/mach-smdk6410.c
> @@ -255,6 +255,7 @@ static struct platform_device *smdk6410_devices[] __initdata = {
> ? ? ? ?&s3c_device_fb,
> ? ? ? ?&s3c_device_ohci,
> ? ? ? ?&s3c_device_usb_hsotg,
> + ? ? ? &s3c64xx_device_iisv4,
Since, we now compile dev-audio.c unconditionally, I think this should be ok.

Acked-by: Jassi Brar <jassi.brar@samsung.com>
