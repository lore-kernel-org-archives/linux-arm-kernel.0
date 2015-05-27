From: tj@kernel.org (Tejun Heo)
Date: Wed, 27 May 2015 10:32:45 -0400
Subject: [PATCH v3 0/3] AHCI: Add generic MSI-X interrupt support to SATA
 PCI driver
In-Reply-To: <1432713693-4282-1-git-send-email-rric@kernel.org>
References: <1432713693-4282-1-git-send-email-rric@kernel.org>
Message-ID: <20150527143245.GN7099@htj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 27, 2015 at 10:01:30AM +0200, Robert Richter wrote:
> From: Robert Richter <rrichter@cavium.com>
> 
> This patch set adds generic support for MSI-X interrupts to the SATA
> PCI driver.
> 
> The first 2 patches rework the code, one splits msi and intx code into
> separate functions, the other changes interrupt initialization to
> store the irq number in the ahci data structure (struct
> ahci_host_priv). Both changes are needed to implement MSI-X support in
> the last 3rd patch.

Patch #2 doesn't apply to libata/for-4.2 due to the recently added
edge triggered irq support.  Can you please refresh the patch series?

Thank you.

-- 
tejun
