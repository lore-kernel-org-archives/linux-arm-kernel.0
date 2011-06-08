From: chrisw@sous-sol.org (Chris Wright)
Date: Wed, 8 Jun 2011 10:47:34 -0700
Subject: [PATCH 4/4] x86: intel-iommu: move to drivers/iommu/
In-Reply-To: <1307522062-19273-5-git-send-email-ohad@wizery.com>
References: <1307522062-19273-1-git-send-email-ohad@wizery.com>
	<1307522062-19273-5-git-send-email-ohad@wizery.com>
Message-ID: <20110608174734.GF23047@sequoia.sous-sol.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ohad Ben-Cohen (ohad at wizery.com) wrote:
> +
> +config DMAR
> +	bool "Support for DMA Remapping Devices (EXPERIMENTAL)"
> +	depends on PCI_MSI && ACPI && EXPERIMENTAL

You may want to further restrict to x86 and ia64
And I think you'll need to fixup arch/ia64/Kconfig

BTW, I think EXPERIMENTAL can be dropped by now.
