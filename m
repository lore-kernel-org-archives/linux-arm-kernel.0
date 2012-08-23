From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Thu, 23 Aug 2012 09:21:04 +0200
Subject: [PATCH 1/2] usb: change the dependency chain for LPC32XX and
 ISP1301
In-Reply-To: <50355A2C.9010505@antcom.de>
References: <Pine.LNX.4.44L0.1208221537260.1328-100000@iolanthe.rowland.org>
 <50355A2C.9010505@antcom.de>
Message-ID: <5035D9E0.1000905@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/23/2012 12:16 AM, Roland Stigge wrote:
> This issue could be resolved in a different way: Have you followed the
> discussion at linux-arm-kernel at lists.infradead.org on 2012-08-20,
> Subject "i2c: pnx: Fix bit definitions"? If nothing unexpected turns
> out, PNX4008 should probably be removed altogether. (Practically
> abandoned arch for 6 years.) Easily possible for v3.7.

Ach. I assumed that is being merged. The PNX arch does not define
USB_ARCH_HAS_OHCI so I goes that you can't select it there?

> Then, the resulting solution is much simpler and Sebastian's patch obsolete.

That would be what?

>
> Thanks,
>
> Roland

Sebastian
