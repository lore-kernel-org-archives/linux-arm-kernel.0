From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 11 Apr 2013 17:28:54 +0200
Subject: [PATCH v5 1/3] of/pci: Unify pci_process_bridge_OF_ranges from
 Microblaze and PowerPC
In-Reply-To: <20130411121242.GB28981@arm.com>
References: <1365578969-30966-1-git-send-email-Andrew.Murray@arm.com>
 <1365578969-30966-2-git-send-email-Andrew.Murray@arm.com>
 <20130410233330.4e9479b0@skate> <20130411121242.GB28981@arm.com>
Message-ID: <20130411172854.61f5728e@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Murray,

On Thu, 11 Apr 2013 13:12:42 +0100, Andrew Murray wrote:

> Thanks - I somehow missed this.
> 
> I've included this change in my next respin - but I've put
> 'struct pci_controller' immediately before
> 'pci_process_bridge_OF_ranges' rather than above of_irq_map_pci to be
> consistent with the rest of the file.

Right, sounds good.

Do we have some news from the PowerPC and Microblaze maintainers about
their acceptance of PATCH 1/3 ? This of/pci thing is the only last
remaining patch for which I need a Ack to get the Marvell PCIe merged.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
