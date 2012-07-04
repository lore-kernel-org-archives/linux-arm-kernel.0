From: pavel@denx.de (Pavel Machek)
Date: Wed, 4 Jul 2012 13:23:58 +0200
Subject: [RFC PATCHv1 1/2] ARM: socfpga: initial support for Altera's
 SOCFPGA platform.
In-Reply-To: <20120704131024.4bb558a3@skate>
References: <1340805007-3313-1-git-send-email-dinguyen@altera.com>
 <1340805007-3313-2-git-send-email-dinguyen@altera.com>
 <20120627162014.1494cdd7@skate> <20120704105653.GA20021@elf.ucw.cz>
 <20120704131024.4bb558a3@skate>
Message-ID: <20120704112358.GB31490@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2012-07-04 13:10:24, Thomas Petazzoni wrote:
> Hello,
> 
> Le Wed, 4 Jul 2012 12:56:53 +0200,
> Pavel Machek <pavel@denx.de> a ?crit :
> 
> > Hmm, strange. I see picoxcell-pc3x2.dtsi using similar
> > dw-apb-uart. According to 8250_dw.c, it is not completely
> > 16550-compatible, and uses slightly modified driver.
> > 
> > So it can be driven from dts, but not as ns16850 compatible. This
> > patch does so.
> 
> I guess your patch misses the .dts bits, but other than that, looks
> much better without this bizarre notifier thing.

It turned out that dts already does the right thing.
  
> Do you plan to resend a complete v2 with all your patches nicely
> rebased? It's not that easy to review such a set of small cleanup
> increments :-)

Sorry about that. Obviously, complete v2 will follow when major
problems are fixed. (We do use git tree for coordination; I guess we
should make it public at this point?)

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
