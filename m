From: avinashphilip@ti.com (Philip, Avinash)
Date: Tue, 11 Jun 2013 12:53:02 +0000
Subject: [PATCH 01/11] ARM: davinci: GPIO: Add platform data structure
In-Reply-To: <51B6FDA2.8080003@ti.com>
References: <1369206634-6778-1-git-send-email-avinashphilip@ti.com>
 <1369206634-6778-2-git-send-email-avinashphilip@ti.com>
 <51B6FDA2.8080003@ti.com>
Message-ID: <518397C60809E147AF5323E0420B992E3EAD9D64@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 11, 2013 at 16:06:18, Nori, Sekhar wrote:
> On 5/22/2013 12:40 PM, Philip Avinash wrote:
> > From: KV Sujith <sujithkv@ti.com>
> > 
> > Add struct davinci_gpio_platform_data davinci gpio module.
> > 
> > Signed-off-by: KV Sujith <sujithkv@ti.com>
> > Signed-off-by: Philip Avinash <avinashphilip@ti.com>
> 
> As Linus commented before, this should be merged with 03/11.

Ok

> 
> > ---
> >  include/linux/platform_data/gpio-davinci.h |   27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >  create mode 100644 include/linux/platform_data/gpio-davinci.h
> > 
> > diff --git a/include/linux/platform_data/gpio-davinci.h b/include/linux/platform_data/gpio-davinci.h
> > new file mode 100644
> > index 0000000..f1c8277
> > --- /dev/null
> > +++ b/include/linux/platform_data/gpio-davinci.h
> > @@ -0,0 +1,27 @@
> > +/*
> > + * gpio-davinci.h
> 
> I would drop this unnecessary filename mention as well.

Ok

> 
> > + *
> > + * DaVinci GPIO Platform Related Defines
> > + *
> > + * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License as
> > + * published by the Free Software Foundation version 2.
> > + *
> > + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> > + * kind, whether express or implied; without even the implied warranty
> > + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#ifndef __ASM_ARCH_DAVINCI_GPIO_H
> > +#define __ASM_ARCH_DAVINCI_GPIO_H
> 
> This should now be __PLATFORM_DATA_DAVINCI_GPIO_H__ or some such since
> the file as been moved out of arch specific folder.

As Sergei pointed out, macro name will change to __GPIO_DAVINCI_H in next revision.

Thanks
Avinash

> 
> Thanks,
> Sekhar
> 
