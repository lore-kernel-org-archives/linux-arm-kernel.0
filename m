From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 21 Jul 2015 17:51:18 +0200 (CEST)
Subject: [RFC Patch V1 00/12] Reorganize struct msi_desc to prepare for
 support of generic MSI
In-Reply-To: <20150721133031.GF16841@google.com>
References: <1436428847-8886-1-git-send-email-jiang.liu@linux.intel.com>
 <20150721133031.GF16841@google.com>
Message-ID: <alpine.DEB.2.11.1507211749590.18576@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 21 Jul 2015, Bjorn Helgaas wrote:
> Sergei pointed out typos in the "Use for_pci_msi_entry()" subject and
> changelogs; I assume you'll fix those.

Yes.

> Paul had a question on 09/12 regarding Kconfig, and I didn't see a
> resolution to that.

I'll reply to that right now.

> For the PCI parts:
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Thomas, I assume you'll take this via your tree.

That's the plan

Thanks,

	tglx
