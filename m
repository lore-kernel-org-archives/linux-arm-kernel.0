From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 14 Sep 2012 14:56:38 +0100
Subject: [PATCH v4 00/24] Introduce Xen support on ARM (based on 3.6-rc5)
In-Reply-To: <20120914132108.GQ25249@phenom.dumpdata.com>
References: <alpine.DEB.2.02.1209141145150.29232@kaball.uk.xensource.com>
 <20120914132108.GQ25249@phenom.dumpdata.com>
Message-ID: <alpine.DEB.2.02.1209141455350.29232@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 14 Sep 2012, Konrad Rzeszutek Wilk wrote:
> I already put in these
> 
> 1)      xen/events: fix unmask_evtchn for PV on HVM guests
> 2)      xen: missing includes
> 3)      xen: update xen_add_to_physmap interface
> 4)      xen: Introduce xen_pfn_t for pfn and mfn types
> 5)      xen: clear IRQ_NOAUTOEN and IRQ_NOREQUEST
> 6)      xen: allow privcmd for HVM guests
> 
> in my tree as they also impact/help the PVH domains which works for
> x86 (Well, not all of them). They are in my stable/for-linus-3.7 git tree
> (git://git.kernel.org/pub/scm/linux/kernel/git/konrad/xen.git)
> and also in #linux-next.
> 
> 
> If it would make reviewing easier, I would recommend you rebase
> your tree on top of the stable/for-linus-3.7 and just post them
> as it would make the number of patches smaller.

I have done that and it went quite smoothly. The patch series is now 5
patches smaller.
Thanks!
