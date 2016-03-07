From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 7 Mar 2016 23:56:05 +0000 (UTC)
Subject: [PATCH 0/2] ARM: dra7: Enable Errata i877
In-Reply-To: <56DD4C70.7070105@ti.com>
References: <1456994525-20573-1-git-send-email-lokeshvutla@ti.com>
 <alpine.DEB.2.02.1603070938170.3437@utopia.booyaka.com>
 <56DD4C70.7070105@ti.com>
Message-ID: <alpine.DEB.2.02.1603072355030.27387@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 7 Mar 2016, Lokesh Vutla wrote:

> On Monday 07 March 2016 03:09 PM, Paul Walmsley wrote:
> > On Thu, 3 Mar 2016, Lokesh Vutla wrote:
> > 
> >> This series enables Errata i877 for all DRA7 platforms. The public errata
> >> documentation can be found here[1].
> >>
> >> [1] http://www.ti.com/lit/er/sprz429h/sprz429h.pdf
> >>
> >> Lokesh Vutla (1):
> >>   ARM: OMAP2+: hwmod: Introduce ti,no-idle dt property
> >>
> >> Mugunthan V N (1):
> >>   ARM: dts: dra7: do not gate cpsw clock due to errata i877
> > 
> > I've sent these for merging immediately. 
> > 
> > Have you sent patches for U-boot yet?
> Yes, It is already merged into u-boot.
> http://git.denx.de/?p=u-boot.git;a=commitdiff;h=f986d9720836433ded29f06c8f5aed462bd20924;hp=65e9d56fb9ce9cfd7ffff7afaa6b7de50e400e06

I may be misreading this patch, but all it seems to do is add clock 
control for GMAC.  It doesn't seem to force the clock to stay on.  What am 
I missing?


- Paul
