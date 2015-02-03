From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 03 Feb 2015 20:15:39 +0100
Subject: [PATCH v4 1/6] ARM: Alpine: Initial support for Alpine platform
In-Reply-To: <54D118EF.4040605@codeaurora.org>
References: <54d0cd1c.JZPcRllcuDW7d5v+%tsahee@annapurnalabs.com>
 <54D118EF.4040605@codeaurora.org>
Message-ID: <4038825.smGnjVluyE@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 February 2015 10:52:31 Stephen Boyd wrote:
> 
> > +     "al,alpine",
> > +     NULL,
> > +};
> > +
> > +DT_MACHINE_START(AL_DT, "Annapurna Labs Alpine")
> > +     .dt_compat      = al_match,
> > +MACHINE_END
> 
> Technically we don't even need this file because the default machine
> descriptor for DT based platforms will work the same.

I currently still prefer to have them, primarily for documenting
what we support, but also to have a nice string in /proc/cpuinfo.

	Arnd
