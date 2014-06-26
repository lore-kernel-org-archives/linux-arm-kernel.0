From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 26 Jun 2014 11:17:07 +0100
Subject: [PATCH v5 1/8] Documentation: arm: define DT idle states bindings
In-Reply-To: <alpine.LFD.2.11.1406251154500.16842@knanqh.ubzr>
References: <1403705421-17597-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1403705421-17597-2-git-send-email-lorenzo.pieralisi@arm.com>
 <alpine.LFD.2.11.1406251154500.16842@knanqh.ubzr>
Message-ID: <20140626101707.GB25130@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 25, 2014 at 04:56:02PM +0100, Nicolas Pitre wrote:
> On Wed, 25 Jun 2014, Lorenzo Pieralisi wrote:
> 
> > ARM based platforms implement a variety of power management schemes that
> > allow processors to enter idle states at run-time.
> > The parameters defining these idle states vary on a per-platform basis forcing
> > the OS to hardcode the state parameters in platform specific static tables
> > whose size grows as the number of platforms supported in the kernel increases
> > and hampers device drivers standardization.
> >
> > Therefore, this patch aims at standardizing idle state device tree bindings for
> > ARM platforms. Bindings define idle state parameters inclusive of entry methods
> > and state latencies, to allow operating systems to retrieve the configuration
> > entries from the device tree and initialize the related power management
> > drivers, paving the way for common code in the kernel to deal with idle
> > states and removing the need for static data in current and previous kernel
> > versions.
> >
> > Reviewed-by: Sebastian Capella <sebcape@gmail.com>
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 
> Excellent.
> 
> Reviewed-by: Nicolas Pitre <nico@linaro.org>

Thanks Nico, there are still a couple of niggles to sort out (ie local
timer state), but the bulk of the document should be complete I hope.

I will postpone adding your (and Seb's) Reviewed-by until we have a
final agreement if it is ok with you.

Thanks !
Lorenzo
