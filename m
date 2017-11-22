From: alan@linux.intel.com (Alan Cox)
Date: Wed, 22 Nov 2017 12:20:47 +0000
Subject: [PATCH 23/30] [media] atomisp: deprecate pci_get_bus_and_slot()
In-Reply-To: <1511328675-21981-24-git-send-email-okaya@codeaurora.org>
References: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
 <1511328675-21981-24-git-send-email-okaya@codeaurora.org>
Message-ID: <1511353247.3539.10.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-11-22 at 00:31 -0500, Sinan Kaya wrote:
> pci_get_bus_and_slot() is restrictive such that it assumes domain=0
> as
> where a PCI device is present. This restricts the device drivers to
> be
> reused for other domain numbers.

The ISP v2 will always been in domain 0.

Alan
