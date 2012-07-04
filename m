From: dinguyen@altera.com (Dinh Nguyen)
Date: Wed, 4 Jul 2012 07:30:16 -0700
Subject: [RFC PATCHv1 1/2] ARM: socfpga: initial support for Altera's
 SOCFPGA platform.
In-Reply-To: <20120704112358.GB31490@elf.ucw.cz>
References: <1340805007-3313-1-git-send-email-dinguyen@altera.com>
 <1340805007-3313-2-git-send-email-dinguyen@altera.com>
 <20120627162014.1494cdd7@skate> <20120704105653.GA20021@elf.ucw.cz>
 <20120704131024.4bb558a3@skate> <20120704112358.GB31490@elf.ucw.cz>
Message-ID: <71B37E0559AC6849A68C5BA94C509FB45830BC6785@SJ-ITMSG02.altera.priv.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> -----Original Message-----
> From: Pavel Machek [mailto:pavel at denx.de]
> Sent: Wednesday, July 04, 2012 6:24 AM
> To: Thomas Petazzoni
> Cc: Dinh Nguyen; linux at arm.linux.org.uk; Kenneth Chong Yin Tan;
> wd at denx.de; linux-arm-kernel at lists.infradead.org
> Subject: Re: [RFC PATCHv1 1/2] ARM: socfpga: initial support for
> Altera's SOCFPGA platform.
>
> On Wed 2012-07-04 13:10:24, Thomas Petazzoni wrote:
> > Hello,
> >
> > Le Wed, 4 Jul 2012 12:56:53 +0200,
> > Pavel Machek <pavel@denx.de> a ?crit :
> >
> > > Hmm, strange. I see picoxcell-pc3x2.dtsi using similar
> > > dw-apb-uart. According to 8250_dw.c, it is not completely
> > > 16550-compatible, and uses slightly modified driver.
> > >
> > > So it can be driven from dts, but not as ns16850 compatible. This
> > > patch does so.
> >
> > I guess your patch misses the .dts bits, but other than that, looks
> > much better without this bizarre notifier thing.
>
> It turned out that dts already does the right thing.
>
> > Do you plan to resend a complete v2 with all your patches nicely
> > rebased? It's not that easy to review such a set of small cleanup
> > increments :-)
>
> Sorry about that. Obviously, complete v2 will follow when major
> problems are fixed. (We do use git tree for coordination; I guess we
> should make it public at this point?)

I'm reworking the patch to use the exisiting clocksource/dw_apb_timer driver.
I'm hoping to have v2 ready for submission by early next week.

Dinh
>
> Thanks,
>                                                                       Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures)
> http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html


Confidentiality Notice.
This message may contain information that is confidential or otherwise protected from disclosure. If you are not the intended recipient, you are hereby notified that any use, disclosure, dissemination, distribution,  or copying  of this message, or any attachments, is strictly prohibited.  If you have received this message in error, please advise the sender by reply e-mail, and delete the message and any attachments.  Thank you.
