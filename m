From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 04 Dec 2013 22:08:47 +0800
Subject: [RFC part1 PATCH 1/7] ACPI: Make ACPI core running without PCI
 on ARM64
In-Reply-To: <20131203164111.GA13447@srcf.ucam.org>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
 <1386088611-2801-2-git-send-email-hanjun.guo@linaro.org>
 <20131203164111.GA13447@srcf.ucam.org>
Message-ID: <529F376F.8050005@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013?12?04? 00:41, Matthew Garrett wrote:
> Given the number of #ifdefs you're adding, wouldn't it make more sense
> to just add stub functions to include/linux/pci.h?

Thanks for the suggestion :)

I can add stub functions in include/linux/pci.h for raw_pci_read()/
raw_pci_write(), then can remove #ifdefs for acpi_os_read/write_pci_configuration().

Thanks
Hanjun

>
