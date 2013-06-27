From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Wed, 26 Jun 2013 22:39:30 -0700 (PDT)
Subject: [PATCH v5 1/3] ARM: shmobile: r8a7778: add VIN support
In-Reply-To: <20130627053037.GI28229@verge.net.au>
References: <201306220326.46176.sergei.shtylyov@cogentembedded.com>
 <201306220328.47110.sergei.shtylyov@cogentembedded.com>
 <877ghg2krp.wl%kuninori.morimoto.gx@renesas.com>
 <20130627053037.GI28229@verge.net.au>
Message-ID: <8738s42ju9.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Simon

> > >  arch/arm/mach-shmobile/clock-r8a7778.c        |    5 +++
> > >  arch/arm/mach-shmobile/include/mach/r8a7778.h |    3 ++
> > >  arch/arm/mach-shmobile/setup-r8a7778.c        |   33 ++++++++++++++++++++++++++
> > >  3 files changed, 41 insertions(+)
> > 
> > Simon (or ARM Maintainer ?) will be happy if clock was separated ?
> 
> Actually, I made a mistake with regards to that.
> I now think it is ok to have them together.
> Sorry for causing you some extra work earlier this month.

OK, thank you :)

Best regards
---
Kuninori Morimoto
