From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 04 Mar 2015 23:27:37 +0100
Subject: [PATCH] genirq: describe IRQF_COND_SUSPEND
In-Reply-To: <20150304221729.GI3989@piout.net>
References: <1424771762-16343-1-git-send-email-boris.brezillon@free-electrons.com>
 <20150304200040.GA12126@leverpostej> <20150304221729.GI3989@piout.net>
Message-ID: <6591581.ooCMyGoxxx@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 March 2015 23:17:29 Alexandre Belloni wrote:
> On 04/03/2015 at 20:00:40 +0000, Mark Rutland wrote :
> > With certain restrictions it is possible for a wakeup device to share
> > and IRQ with an IRQF_NO_SUSPEND user, and the warnings introduced by
>   ^ an
> 
> 
> > +In rare cases an IRQ can be shared between a wakeup device driver and an
> > +IRQF_NO_SUSPEND user. In order for this to be safe, the wakeup device driver
> > +must be able to discern spurious IRQs from genuine wakeup events (signalling
> 
> And genuine question, should we use British English or American English
> or we don't care ?

I believe most developers use Incorrect English, the second most common
is American English, followed by Indian English and British English. ;-)

More seriously, just try to be consistent within one file or subsystem.

	Arnd
