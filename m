From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 29 Jan 2013 15:29:37 +0100
Subject: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
In-Reply-To: <20130129142015.GA23640@avionic-0098.mockup.avionic-design.de>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130129132204.GA23886@arm.com> <20130129144522.44ed7373@skate>
 <20130129140522.GA24310@arm.com>
 <20130129142015.GA23640@avionic-0098.mockup.avionic-design.de>
Message-ID: <20130129152937.53ec9a9b@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Thierry Reding,

On Tue, 29 Jan 2013 15:20:15 +0100, Thierry Reding wrote:

> If at all possible I think the right thing to do is reuse the generic
> pcibios_get_phb_of_node() implementation. On Tegra this turned out to
> require a minimal change to the DT bindings of the root port nodes to
> make sure they provide the correct address in the reg property.

Could you detail the change that was needed? The DT bindings I use for
the Marvell PCIe driver are very, very similar to the ones you use for
Tegra, since I basically inspired my entire DT binding on your work.
And still, I think of_irq_map_pci() wasn't working for me.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
