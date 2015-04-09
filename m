From: tony@atomide.com (Tony Lindgren)
Date: Thu, 9 Apr 2015 12:01:27 -0700
Subject: [PATCH v5 8/8] ARM: DTS: dra7x: Integrate sDMA crossbar
In-Reply-To: <5526C9E5.4070601@ti.com>
References: <1428572154-3548-1-git-send-email-peter.ujfalusi@ti.com>
 <1428572154-3548-9-git-send-email-peter.ujfalusi@ti.com>
 <20150409151846.GR18048@atomide.com> <5526C9E5.4070601@ti.com>
Message-ID: <20150409190126.GT18048@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [150409 11:55]:
> On 04/09/2015 06:18 PM, Tony Lindgren wrote:
> > * Peter Ujfalusi <peter.ujfalusi@ti.com> [150409 02:37]:
> >> The sDMA requests are routed through the DMA crossbar and without the
> >> crossbar only peripherals using DMA request 0-127 can be used.
> > 
> > I assume this can be merged separately from the driver
> > changes?
> 
> Unfortunately not. We need to have the drivers in place for the DTS changes to
> work.

Right but just merging the driver changes presumably won't
break things?

Regards,

Tony
