From: rostedt@goodmis.org (Steven Rostedt)
Date: Mon, 02 Jul 2012 12:35:31 -0400
Subject: [PATCH 2 2/4] net ethernet introduce mac_la_ap helper
In-Reply-To: <201207021612.57028.arnd@arndb.de>
References: <20120702063545.26782.98908.stgit@build.warmcat.com>
 <20120702064054.26782.79849.stgit@build.warmcat.com>
 <201207021612.57028.arnd@arndb.de>
Message-ID: <1341246931.6578.10.camel@gandalf.stny.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-07-02 at 16:12 +0000, Arnd Bergmann wrote:

> >  include/net/mac-la-ap.h  |   28 ++++++++
> >  net/Kconfig              |   14 ++++
> >  net/ethernet/Makefile    |    2 +
> >  net/ethernet/mac-la-ap.c |  165 ++++++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 209 insertions(+)
> >  create mode 100644 include/net/mac-la-ap.h
> >  create mode 100644 net/ethernet/mac-la-ap.c
> > diff --git a/include/net/mac-la-ap.h b/include/net/mac-la-ap.h
> > new file mode 100644
> > index 0000000..d5189b5
> > --- /dev/null
> > +++ b/include/net/mac-la-ap.h
> > @@ -0,0 +1,28 @@
> > +/*
> > + * mac-la-ap.h:  Locally Administered MAC address for Async probed devices
> > + */
> 
> I find the name a bit non-obvious, not sure if we can come up with the
> perfect one.
> 
> How about mac-platform?

I really find it unfortunate that 'mac' for ethernet has the same name
as the Apple box as well. 'mac' in other contexts can usually
differentiate these two, but saying 'mac-platform' just screams of
forbidden fruit.

mac-probe.h ?

-- Steve
