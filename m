From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 25 Apr 2013 11:14:43 +0100
Subject: [PATCH v4 7/7] mach-virt: support Xen hypercalls for shutdown
 and reboot
In-Reply-To: <20130425085452.GC12848@mudshark.cambridge.arm.com>
References: <alpine.DEB.2.02.1304242012590.4180@kaball.uk.xensource.com>
 <1366831695-13214-7-git-send-email-stefano.stabellini@eu.citrix.com>
 <alpine.DEB.2.02.1304242301390.4180@kaball.uk.xensource.com>
 <20130425085452.GC12848@mudshark.cambridge.arm.com>
Message-ID: <alpine.DEB.2.02.1304251114280.4180@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Apr 2013, Will Deacon wrote:
> On Wed, Apr 24, 2013 at 11:14:28PM +0100, Stefano Stabellini wrote:
> > On Wed, 24 Apr 2013, Stefano Stabellini wrote:
> > > Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > > CC: Marc Zyngier <marc.zyngier@arm.com>
> > > CC: will.deacon at arm.com
> > > CC: arnd at arndb.de
> > > CC: rob.herring at calxeda.com
> > 
> > Thinking twice about this patch, a less intrusive alternative would be
> > to set arm_pm_restart and pm_power_off to two xen specific functions
> > later on from xen_guest_init.
> 
> Yes please. We'd like to remove mach-virt/* some day.

I'll do
