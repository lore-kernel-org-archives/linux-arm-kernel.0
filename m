From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 30 Jun 2014 17:02:38 +0300
Subject: [PATCH 1/2] clk: samsung: fix several typos to fix boot on s3c2410
In-Reply-To: <53B16B06.6070206@samsung.com>
References: <1403555350-14895-1-git-send-email-anarsoul@gmail.com>
 <53B16B06.6070206@samsung.com>
Message-ID: <1519968.Vijxn8Mc9S@vasilykh-desktop-i5>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 June 2014 15:49:58 Tomasz Figa wrote:
> On 23.06.2014 22:29, Vasily Khoruzhick wrote:
> > There's a several typos in a driver: 2410 instead of S3C2410
> > and wrong argument to ARRAY_SIZE(). They prevent s3c2410
> > from properly booting.
> > 
> > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > ---
> > 
> >  drivers/clk/samsung/clk-s3c2410.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Applied as a fix for 3.16.

Hi Tomasz,

I also have clk fixes for s3c24xx touchscreen, framebuffer, adc, usb and nand 
drivers (to replace clk_enable with clk_prepare_enable and clk_disable with 
clk_disable_unprepare),

Should they be merged through different trees or it's possible to merge them 
through a single tree?

> 
> Best regards,
> Tomasz

Regards
Vasily
