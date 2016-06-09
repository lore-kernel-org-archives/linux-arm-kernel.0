From: helgaas@kernel.org (Bjorn Helgaas)
Date: Thu, 9 Jun 2016 17:31:10 -0500
Subject: [PATCH v2 0/2] pci: host: Broadcom STB PCIE RC controller support
In-Reply-To: <1462475700-1654-1-git-send-email-f.fainelli@gmail.com>
References: <1462475700-1654-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <20160609223110.GA19309@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 05, 2016 at 12:14:58PM -0700, Florian Fainelli wrote:
> Hi all,
> 
> This patch series adds support for Broadcom STB SoC's PCIe root complex driver.
> 
> This was primarily tested on BCM7445 (ARM) and BCM7435 (MIPS).
> 
> Jim is the original author, and I picked up our downstream 4.1 driver and
> updated it to utilize the non-ARM hw_pci functions as well as made some
> stylistic changes.
> 
> Thanks!
> 
> Jim Quinlan (2):
>   Documentation: DT: bindings: Add Broadcom STB PCIe bindings
>   pci: host: Add Broadcom STB PCIE RC controller

Hi Florian,

There was some discussion about these patches, so I assume you'll post
a new version addressing that.  When you do, can you include
/proc/iomem and /proc/ioports contents?

I'm looking to avoid problems like this:
http://lkml.kernel.org/r/20160606230537.20936.2892.stgit at bhelgaas-glaptop2.roam.corp.google.com

Also, it will save me time if you take note of this:
http://lkml.kernel.org/r/20160607231326.GA4759 at localhost

Bjorn
