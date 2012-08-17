From: tony@atomide.com (Tony Lindgren)
Date: Fri, 17 Aug 2012 00:52:41 -0700
Subject: [PATCH v2 3/3] ARM: OMAP: omap_device: idle devices with no
 driver bound
In-Reply-To: <alpine.DEB.2.00.1208101658130.29149@utopia.booyaka.com>
References: <1344623953-26434-1-git-send-email-khilman@ti.com>
 <1344623953-26434-4-git-send-email-khilman@ti.com>
 <alpine.DEB.2.00.1208101658130.29149@utopia.booyaka.com>
Message-ID: <20120817075240.GM11011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [120810 15:59]:
> On Fri, 10 Aug 2012, Kevin Hilman wrote:
> 
> > Under some circumstances, drivers may leave an omap_device enabled due
> > to driver programming errors, or due to a failure in the drivers
> > probe method.
> > 
> > Using the recently added omap_device driver_status field, we can
> > detect conditions where an omap_device is enabled but has no driver
> > bound and then ensure that the device is properly idled until it can
> > be probed again.
> > 
> > The goal of this feature is not only to detect and warn on these error
> > conditions, but also to ensure that devices are properly put in
> > low-power states so they do not prevent SoC-wide low-power states.
> > 
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Signed-off-by: Kevin Hilman <khilman@ti.com>
> 
> Here's the queued version of this one.

Nice to see this happening :)

Tony
