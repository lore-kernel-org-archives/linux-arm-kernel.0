From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 30 Sep 2011 09:06:13 +0100
Subject: [PATCH 5/5] ARM: pxa: move gpio driver into drivers directory
In-Reply-To: <CAN1soZyBTOq_qQ+o3OFP-GuwRN=WwNE6te1Hy7vrkureFuLA3A@mail.gmail.com>
References: <1317309546-19682-5-git-send-email-haojian.zhuang@marvell.com>
	<20110929163048.GA21718@n2100.arm.linux.org.uk>
	<CAN1soZyBTOq_qQ+o3OFP-GuwRN=WwNE6te1Hy7vrkureFuLA3A@mail.gmail.com>
Message-ID: <20110930080613.GA10278@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 30, 2011 at 03:09:11PM +0800, Haojian Zhuang wrote:
> On Fri, Sep 30, 2011 at 12:30 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Thu, Sep 29, 2011 at 11:19:06PM +0800, Haojian Zhuang wrote:
> >> +#include <linux/gpio-pxa.h>
> >> +#include <linux/platform_device.h>
> >> +
> >> +#include <asm/io.h>
> >
> > linux/gpio.h please.
> >
> 
> Excuse me that I didn't use any gpio API in mach-pxa/gpio.c. It seems
> that I needn't include "linux/gpio.h" at mach-pxa/gpio.c.

Sorry, that should've been linux/io.h not gpio.h
