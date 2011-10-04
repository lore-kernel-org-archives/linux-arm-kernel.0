From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 4 Oct 2011 09:57:42 +0100
Subject: [PATCH] Add missing include of linux/ftrace.h
In-Reply-To: <CAH+eYFBESAp8Hz6fBAqjWSgAkzPuAub4JqU4r3SDU+TQTRagBA@mail.gmail.com>
References: <1317309202-1001-1-git-send-email-jamie@jamieiles.com>
	<20111001163511.GI11710@n2100.arm.linux.org.uk>
	<20111001171202.GA13684@gallagher>
	<CAH+eYFBESAp8Hz6fBAqjWSgAkzPuAub4JqU4r3SDU+TQTRagBA@mail.gmail.com>
Message-ID: <20111004085742.GA1977@totoro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 02, 2011 at 12:34:45AM +0530, Rabin Vincent wrote:
> On Sat, Oct 1, 2011 at 22:42, Jamie Iles <jamie@jamieiles.com> wrote:
> > diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
> > index de3dcab..61c1468 100644
> > --- a/arch/arm/kernel/irq.c
> > +++ b/arch/arm/kernel/irq.c
> > @@ -37,6 +37,7 @@
> > ?#include <linux/proc_fs.h>
> > ?#include <linux/ftrace.h>
> 
> You can probably git rid of this inclusion of ftrace.h from
> here and from smp.c, because they were added only for
> __exception_irq_entry.

OK, I've updated the patch in Russell's tracker removing these includes.

Jamie
