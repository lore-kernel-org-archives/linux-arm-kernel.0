From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Dec 2009 15:04:25 +0000
Subject: [PATCH 6/7] ARM: S5P6440: Add Board and configuration file
In-Reply-To: <20091218155711.5a3efd99@life-in-the-fast-lane>
References: <1261127996-30253-1-git-send-email-kgene.kim@samsung.com>
	<1261127996-30253-2-git-send-email-kgene.kim@samsung.com>
	<20091218155711.5a3efd99@life-in-the-fast-lane>
Message-ID: <20091218150425.GA5271@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2009 at 03:57:11PM +0100, Marc Zyngier wrote:
> On Fri, 18 Dec 2009 18:19:53 +0900
> Kukjin Kim <kgene.kim@samsung.com> wrote:
> > +
> > +#include <mach/hardware.h>
> > +#include <mach/map.h>
> > +
> > +#include <asm/irq.h>
> 
> Please don't directly include asm/irq.h. Use linux/irq.h instead.

That's one of the exceptions to the "use linux/foo.h instead of asm/foo.h"
rule.

Code is fine as is.
