From: tony@atomide.com (Tony Lindgren)
Date: Tue, 9 Oct 2012 17:19:44 -0700
Subject: [PATCH 1/2] ARM: OMAP: Trivial driver changes to remove
 include plat/cpu.h
In-Reply-To: <5073E84E.4090408@ti.com>
References: <20121008173452.10603.53886.stgit@muffinssi>
 <20121008173557.10603.18539.stgit@muffinssi>
 <5073E84E.4090408@ti.com>
Message-ID: <20121010001943.GK12552@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* P?ter Ujfalusi <peter.ujfalusi@ti.com> [121009 02:03]:
> On 10/08/2012 07:35 PM, Tony Lindgren wrote:
> 
> > - omap-dma.c and omap-pcm.c can test the arch locally as
> >   omap1 and omap2 cannot be compiled together because of
> >   conflicting compiler flags
> 
> >  sound/soc/omap/omap-pcm.c         |    9 +++++++--
> 
> Tony: is this going to be included in 3.7?

Hmm I guess we could try to get this out of the way
to cut down the dependencies. Let's if maintainers
of the other affected drivers this is OK for the
-rc series.

Regards,

Tony
