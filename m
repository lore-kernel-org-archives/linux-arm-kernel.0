From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 02 Jun 2010 11:34:31 +0900
Subject: [PATCH 3/4] ARM: S5PC100: Add support for Compact Flash driver	on
	SMDKC100
In-Reply-To: <20100527194714.GE25921@n2100.arm.linux.org.uk>
References: <1274948524-2970-1-git-send-email-kgene.kim@samsung.com>
	<1274948524-2970-4-git-send-email-kgene.kim@samsung.com>
	<20100527194714.GE25921@n2100.arm.linux.org.uk>
Message-ID: <002801cb01fc$245ad4f0$6d107ed0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> 
> On Thu, May 27, 2010 at 05:22:03PM +0900, Kukjin Kim wrote:
> > +#include <linux/kernel.h>
> > +#include <linux/types.h>
> > +#include <linux/io.h>
> > +
> > +#include <mach/gpio.h>
> 
> linux/gpio.h ?

Will change it :-)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
