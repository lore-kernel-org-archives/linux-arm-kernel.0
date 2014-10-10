From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 10 Oct 2014 11:29:03 -0400
Subject: [PATCH] ARM: keystone: add bus notifier to set dma_pfn_offset
 for pci devices
In-Reply-To: <1412954137-4567-1-git-send-email-m-karicheri2@ti.com>
References: <1412954137-4567-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <5437FB3F.4010906@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/10/14 11:15 AM, Murali Karicheri wrote:
> When PCI device driver such as that for e1000e tries to set dma mask
> using dma_set_mask_and_coherent(), it fails because the dma_pfn_offset
> is incorrect on a Keystone SoC. This patch fix this by adding a bus
> notifier to set this correctly for PCI devices.
>
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> ---
Looks good. I will pick this up after the merge window.
Please send this patch along with PCI dts patches
together once the rc1 is tagged.

Regards,
Santosh
