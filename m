From: rpjday@crashcourse.ca (Robert P. J. Day)
Date: Sat, 26 Sep 2009 21:51:22 -0400 (EDT)
Subject: [PATCH] ARM: OMAP: Remove unused CONFIG MACH_OMAP_HTCWIZARD
In-Reply-To: <3d374d00909261836g38ceceb0p3fed39ac62103c33@mail.gmail.com>
References: <1253974303.4568.13.camel@ht.satnam>
	<3d374d00909261836g38ceceb0p3fed39ac62103c33@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.0909262148100.6153@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 27 Sep 2009, Alistair Buxton wrote:

> 2009/9/26 Jaswinder Singh Rajput <jaswinder@kernel.org>:
> >
> > Remove unused CONFIG MACH_OMAP_HTCWIZARD from Kconfig
>
> Don't do it please! We're working on it.... board file is coming
> very soon.

  i've noticed that happening fairly often -- feature infrastructure
is added before the feature itself.  at the risk of sounding all
preachy and everything, that sort of thing should be avoided in order
to keep the history cleaner.  and because that's *exactly* the sort of
thing that, occasionally, produces the kind of historical cruft that
leaves unused CONFIG variables lying around when a feature is
abandoned in midstream.

  ok, i'll stop preaching now.

rday
--


========================================================================
Robert P. J. Day                               Waterloo, Ontario, CANADA

        Linux Consulting, Training and Annoying Kernel Pedantry.

Web page:                                          http://crashcourse.ca
Twitter:                                       http://twitter.com/rpjday
========================================================================
