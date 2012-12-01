From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Sat, 01 Dec 2012 17:14:48 +0400
Subject: =?UTF-8?B?UmVbMl06IFtQQVRDSF0gQVJNOiBpeHA0eHg6IEFkZCAiYXNrIiBoYW5kbGVy?=
 =?UTF-8?B?IGZvciB0aW1lciBpbnRlcnJ1cHRz?=
In-Reply-To: <20121201130527.GD12509@titan.lakedaemon.net>
References: <1354347213-22237-1-git-send-email-shc_work@mail.ru>
 <20121201130527.GD12509@titan.lakedaemon.net>
Message-ID: <1354367688.468230210@f2.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Sat, Dec 01, 2012 at 11:33:33AM +0400, Alexander Shiyan wrote:
> > Rather than modify the EOI flags directly in the timer interrupt,
> > let's deal with these flags in the "ask" procedure.
> 
> Please specify the procedure name instead of "ask", eg ixp4xx_irq_ack().
> Same goes for the Subject line.
> 
> What brought about this change, is this part of a larger series?

It all started with an attempt to clear the unneeded calls from drivers.
Series not yet, just an initial attempt to put everything in its place.

---
