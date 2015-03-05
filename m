From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 5 Mar 2015 08:02:45 +0000
Subject: [PATCH v5 8/9] rtc: st: add new driver for ST's LPC RTC
In-Reply-To: <1425497072.2090.4.camel@tiscali.nl>
References: <1425492398-27340-1-git-send-email-lee.jones@linaro.org>
 <1425492398-27340-9-git-send-email-lee.jones@linaro.org>
 <1425497072.2090.4.camel@tiscali.nl>
Message-ID: <20150305080245.GA31098@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 04 Mar 2015, Paul Bolle wrote:

> Lee Jones schreef op wo 04-03-2015 om 18:06 [+0000]:
> > --- /dev/null
> > +++ b/drivers/rtc/rtc-st-lpc.c
> > @@ -0,0 +1,354 @@
> > +/*
> > + * rtc-st-lpc.c - ST's LPC RTC, powered by the Low Power Timer
> > + *
> > + * Copyright (C) 2014 STMicroelectronics Limited
> > + *
> > + * Author: David Paris <david.paris@st.com> for STMicroelectronics
> > + *         Lee Jones <lee.jones@linaro.org> for STMicroelectronics
> > + *
> > + * Based on the original driver written by Stuart Menefy.
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public Licence
> > + * as published by the Free Software Foundation; either version
> > + * 2 of the Licence, or (at your option) any later version.
> > + */
> 
> This states the license is GPL v2 or later.
> 
> > +MODULE_LICENSE("GPLv2");
> 
> This will taint the kernel at module load, won't it? You probably meant
> "GPL v2", but only
>     MODULE_LICENSE("GPL");
> 
> correctly matches the license in the comment at the top of this file. 
> 
> (I assume I missed all this when looking at the v4 series.)

Actually, I've already fixed this along with another typo I found
after resubmitting.  Always the way sadly.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
