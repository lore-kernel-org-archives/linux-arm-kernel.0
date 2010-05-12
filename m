From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 12 May 2010 19:38:13 +0900
Subject: [PATCH v2] ARM: S5PV210: Add S5PV210 GPIO support.
In-Reply-To: <20100512102839.GA22371@n2100.arm.linux.org.uk>
References: <1273659531-6151-1-git-send-email-kgene.kim@samsung.com>
	<20100512102839.GA22371@n2100.arm.linux.org.uk>
Message-ID: <003101caf1bf$3c62b5b0$b5282110$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King wrote:
> 
> On Wed, May 12, 2010 at 07:18:51PM +0900, Kukjin Kim wrote:
> > +#include <linux/kernel.h>
> > +#include <linux/irq.h>
> > +#include <linux/io.h>
> > +#include <mach/map.h>
> > +#include <mach/gpio.h>
> 
> It's linux/gpio.h

Oh ok, I will fix it.

Thanks for your comment.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
