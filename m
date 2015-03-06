From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Fri, 06 Mar 2015 01:54:39 +0100
Subject: [PATCH] genirq: describe IRQF_COND_SUSPEND
In-Reply-To: <20150305110411.GC13617@leverpostej>
References: <1424771762-16343-1-git-send-email-boris.brezillon@free-electrons.com>
 <20150304221729.GI3989@piout.net> <20150305110411.GC13617@leverpostej>
Message-ID: <33158689.4nZBVOb2gz@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, March 05, 2015 11:04:11 AM Mark Rutland wrote:
> On Wed, Mar 04, 2015 at 10:17:29PM +0000, Alexandre Belloni wrote:
> > tiny tiny nitpick:
> > 
> > On 04/03/2015 at 20:00:40 +0000, Mark Rutland wrote :
> > > With certain restrictions it is possible for a wakeup device to share
> > > and IRQ with an IRQF_NO_SUSPEND user, and the warnings introduced by
> >   ^ an
> 
> Whoops.
> 
> Rafael, are you happy to fix that up, or would you like me to resend?

Fixed, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
