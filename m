From: Wenyou.Yang@microchip.com (Wenyou.Yang at microchip.com)
Date: Tue, 19 Dec 2017 11:54:03 +0000
Subject: [PATCH v9 2/2] media: i2c: Add the ov7740 image sensor driver
In-Reply-To: <20171219092246.3usg5mdyi27ivqlq@valkosipuli.retiisi.org.uk>
References: <20171211013146.2497-1-wenyou.yang@microchip.com>
 <20171211013146.2497-3-wenyou.yang@microchip.com>
 <20171219092246.3usg5mdyi27ivqlq@valkosipuli.retiisi.org.uk>
Message-ID: <F9F4555C4E01D7469D37975B62D0EFBB8DE616@CHN-SV-EXMX07.mchp-main.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sakari,

> -----Original Message-----
> From: Sakari Ailus [mailto:sakari.ailus at iki.fi]
> Sent: 2017?12?19? 17:23
> To: Wenyou Yang - A41535 <Wenyou.Yang@microchip.com>
> Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>; Rob Herring
> <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; linux-
> kernel at vger.kernel.org; Nicolas Ferre - M43238 <Nicolas.Ferre@microchip.com>;
> devicetree at vger.kernel.org; Jonathan Corbet <corbet@lwn.net>; Hans Verkuil
> <hverkuil@xs4all.nl>; linux-arm-kernel at lists.infradead.org; Linux Media Mailing List
> <linux-media@vger.kernel.org>; Songjun Wu <songjun.wu@microchip.com>
> Subject: Re: [PATCH v9 2/2] media: i2c: Add the ov7740 image sensor driver
> 
> On Mon, Dec 11, 2017 at 09:31:46AM +0800, Wenyou Yang wrote:
> > The ov7740 (color) image sensor is a high performance VGA CMOS image
> > snesor, which supports for output formats: RAW RGB and YUV and image
> > sizes: VGA, and QVGA, CIF and any size smaller.
> >
> > Signed-off-by: Songjun Wu <songjun.wu@microchip.com>
> > Signed-off-by: Wenyou Yang <wenyou.yang@microchip.com>
> 
> Applied with this diff:

Thank you very much.

> 
> diff --git a/drivers/media/i2c/ov7740.c b/drivers/media/i2c/ov7740.c index
> 0308ba437bbb..041a77039d70 100644
> --- a/drivers/media/i2c/ov7740.c
> +++ b/drivers/media/i2c/ov7740.c
> @@ -1,5 +1,7 @@
> -// SPDX-License-Identifier: GPL-2.0
> -// Copyright (c) 2017 Microchip Corporation.
> +/*
> + * SPDX-License-Identifier: GPL-2.0
> + * Copyright (c) 2017 Microchip Corporation.
> + */
> 
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> 
> --
> Sakari Ailus
> e-mail: sakari.ailus at iki.fi


Best Regards,
Wenyou Yang
