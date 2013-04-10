From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 10 Apr 2013 23:30:59 +0200
Subject: [PATCH v5 1/3] of/pci: Unify pci_process_bridge_OF_ranges from
 Microblaze and PowerPC
In-Reply-To: <51656592.7070806@gmail.com>
References: <1365578969-30966-1-git-send-email-Andrew.Murray@arm.com>
 <1365578969-30966-2-git-send-email-Andrew.Murray@arm.com>
 <51656592.7070806@gmail.com>
Message-ID: <20130410233059.5cdcc119@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ben, Michal,

On Wed, 10 Apr 2013 08:13:54 -0500, Rob Herring wrote:
> Adding Ben H and Michal...
> 
> On 04/10/2013 02:29 AM, Andrew Murray wrote:
> > The pci_process_bridge_OF_ranges function, used to parse the
> > "ranges" property of a PCI host device, is found in both Microblaze
> > and PowerPC architectures. These implementations are nearly
> > identical. This patch moves this common code to a common place.
> > 
> > Signed-off-by: Andrew Murray <Andrew.Murray@arm.com>
> > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> 
> One comment below. Otherwise,
> 
> Reviewed-by: Rob Herring <rob.herring@calxeda.com>
> 
> You need also need acks from Ben and Michal.

Ben, Michal, could you review/test this patch from Andrew Murray? I
need it as a dependency of "[PATCH v5 2/3] of/pci: Provide support for
parsing PCI DT ranges property", which itself is used by the Marvell
PCIe driver I'm hoping to get merged in 3.10.

Thanks a lot for your feedback,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
