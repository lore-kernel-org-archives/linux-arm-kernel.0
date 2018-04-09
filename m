From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Mon, 9 Apr 2018 20:54:33 +0200
Subject: [PATCH v4 0/6] PCI: aardvark: misc fixes and improvements
In-Reply-To: <20180409162356.GB14533@e107981-ln.cambridge.arm.com>
References: <20180406145536.19637-1-thomas.petazzoni@bootlin.com>
 <20180409162356.GB14533@e107981-ln.cambridge.arm.com>
Message-ID: <20180409205433.4eb78a45@windsurf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Lorenzo,

Thanks for your feedback!

On Mon, 9 Apr 2018 17:23:56 +0100, Lorenzo Pieralisi wrote:

> it is not just improvements, these look like significant bug fixes too.
> 
> Let me know which patches we should prioritize since hopefully they can
> be sent during v4.17-rc* releases, I will queue the rest for the next
> merge window.

The patches that are bug fixes are marked with a "Fixes:" tag and are
Cc'ed to stable.

So, the following patches are fixes:

[PATCH v4 1/6] PCI: aardvark: Fix logic in advk_pcie_{rd,wr}_conf()
[PATCH v4 2/6] PCI: aardvark: Set PIO_ADDR_LS correctly in advk_pcie_rd_conf()
[PATCH v4 3/6] PCI: aardvark: Use ISR1 instead of ISR0 interrupt in legacy irq mode
[PATCH v4 4/6] PCI: aardvark: Fix PCIe Max Read Request Size setting

The following patches are improvements:

[PATCH v4 5/6] PCI: aardvark: Introduce an advk_pcie_valid_device() helper
[PATCH v4 6/6] PCI: aardvark: Remove PCIe outbound window configuration

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
