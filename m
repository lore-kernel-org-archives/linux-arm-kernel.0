From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 20 May 2015 17:16:39 +0200
Subject: Problems with device tree PMC clocks and threadirqs on at91
In-Reply-To: <CANfhG66vxOxXB+jZYz_UhbjFpRL6ceMGJD+K5X0H_js=3U1_Zw@mail.gmail.com>
References: <555C8117.9010508@pcs.com> <20150520151008.76e180db@bbrezillon>
 <CANfhG66vxOxXB+jZYz_UhbjFpRL6ceMGJD+K5X0H_js=3U1_Zw@mail.gmail.com>
Message-ID: <20150520171639.03d6d081@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 20 May 2015 17:14:02 +0200
"D. Dueck" <davidcdueck@googlemail.com> wrote:

> 2015-05-20 15:10 GMT+02:00 Boris Brezillon <boris.brezillon@free-electrons.com>:
> 
> > That's my favorite option. But it also implies modify all other
> > interrupts handler registered on irq line 1 to use IRQF_NO_THREAD (PMC,
> > RTC, WDT, ...)
> 
> And those handlers currently take spin locks. So that is also not that simple.

Yes, I forgot that aspect, thanks for the reminder.



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
