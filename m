From: paul@pwsan.com (Paul Walmsley)
Date: Sun, 15 Jun 2014 03:47:32 +0000 (UTC)
Subject: [PATCH] ARM: DRA7: hwmod: add entry for RTCSS
In-Reply-To: <alpine.DEB.2.02.1406131908260.340@utopia.booyaka.com>
References: <f99196358a3cc28b0bd451459badcfc286533845.1399638849.git.nsekhar@ti.com>
 <alpine.DEB.2.02.1406131908260.340@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.02.1406150346050.659@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 13 Jun 2014, Paul Walmsley wrote:

> On Fri, 9 May 2014, Sekhar Nori wrote:
> 
> > From: Lokesh Vutla <lokeshvutla@ti.com>
> > 
> > RTCSS on DRA7 provides a precise real-time clock.
> > Add hwmod entry for this IP.
> > 
> > Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> > Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> 
> Sorry for the delay on this patch.  Have been corresponding with TI to 
> figure out what to do about DRA7xx/AM43xx patches.  I don't have boards or 
> public documentation for these devices, so it's impossible for me to 
> meaningfully review the patches.  Looks like boards and/or public docs 
> won't be coming any time soon.
> 
> So for my part, here's what I'll need to merge any hwmod patches that
> involve AM437x or DRA7xx:
> 
> 1. A Reviewed-by: from one of the following folks (which should come from
> a different person than who is submitting the patches):
> 
> Roger Quadros
> Nishanth Menon
> Rajendra Nayak
> Kevin Hilman
> Tony Lindgren
> 
> 2. A Tested-by: from one of the following folks (who can be the same as 
> the person who is the same as the person who is submitting the patches):
> 
> Nishanth Menon
> Rajendra Nayak
> Kevin Hilman 
> Tony Lindgren
> 
> 
> Once these are in place, I'd be happy to queue it for 3.16.

I've tried to refine this a little bit.  More details here:

http://marc.info/?l=linux-omap&m=140280321814330&w=2

- Paul
