From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 May 2011 18:50:03 +0100
Subject: [PATCH 1/2] ARM: pxa: raumfeld: follow upcoming hardware change
In-Reply-To: <1306239223-8293-1-git-send-email-zonque@gmail.com>
References: <1306239223-8293-1-git-send-email-zonque@gmail.com>
Message-ID: <20110524175002.GB4652@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 24, 2011 at 02:13:42PM +0200, Daniel Mack wrote:
> The backlight control is going to change back to PWM in the
> upcoming Raumfeld Controller hardware revision.

The commit comments doesn't say why the LCD timings have changed:

> @@ -574,10 +574,10 @@ static struct pxafb_mode_info sharp_lq043t3dx02_mode = {
>  	.xres		= 480,
>  	.yres		= 272,
>  	.bpp		= 16,
> -	.hsync_len	= 4,
> +	.hsync_len	= 41,
>  	.left_margin	= 2,
>  	.right_margin	= 1,
> -	.vsync_len	= 1,
> +	.vsync_len	= 10,
>  	.upper_margin	= 3,
>  	.lower_margin	= 1,
>  	.sync		= 0,
