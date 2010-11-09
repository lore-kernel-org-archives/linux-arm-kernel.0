From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 9 Nov 2010 10:33:12 +0000
Subject: [PATCH 6/6 v3] ARM: Add support for the display controllers in
	VT8500 and WM8505
In-Reply-To: <20101108204315.GA12050@linux-sh.org>
References: <1289147348-31969-1-git-send-email-alchark@gmail.com>
	<1289147348-31969-6-git-send-email-alchark@gmail.com>
	<20101108041721.GA11605@linux-sh.org>
	<20101108141407.GA25739@alchark-u3s.lan>
	<20101108204315.GA12050@linux-sh.org>
Message-ID: <20101109103312.GA2869@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 09, 2010 at 05:43:16AM +0900, Paul Mundt wrote:
> > diff --git a/drivers/video/vt8500lcdfb.c b/drivers/video/vt8500lcdfb.c
> > new file mode 100644
> > index 0000000..640d8a3
> > --- /dev/null
> > +++ b/drivers/video/vt8500lcdfb.c
> > +#include <asm/irq.h>
> > +
> linux/irq.h is preferred here.

I assume you've read the comment at the top of linux/irq.h ?
