From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 20 Jul 2015 22:46:37 +0200 (CEST)
Subject: [PATCH 1/3] clocksource: atmel-st: Remove irq handler when clock
 event is unused
In-Reply-To: <20150720193726.GJ15539@piout.net>
References: <1437161608-26782-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1437161608-26782-2-git-send-email-alexandre.belloni@free-electrons.com>
 <alpine.DEB.2.11.1507180942360.18576@nanos>
 <20150718222308.GA30489@piout.net>
 <alpine.DEB.2.11.1507201103550.18576@nanos> <20150720193726.GJ15539@piout.net>
Message-ID: <alpine.DEB.2.11.1507202245310.18576@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 20 Jul 2015, Alexandre Belloni wrote:

> On 20/07/2015 at 11:04:30 +0200, Thomas Gleixner wrote :
> > That's why I used setup/remove_irq() in the stale RT changes.
> > 
> 
> Hum, actually, you hit the same thing with setup/remove_irq (and I'm not sure
> to follow why):

It's the kmalloc of the proc interface. So back to the drawing
board. I'll think about it tomorrow with brain awake.

Thanks,

	tglx
