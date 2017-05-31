From: jtoppins@redhat.com (Jonathan Toppins)
Date: Wed, 31 May 2017 07:29:15 -0400
Subject: [PATCH v2 pci] PCI/MSI: pci-xgene-msi: Enable MSI support in ACPI
 boot for X-Gene v1
In-Reply-To: <1493340847-25720-1-git-send-email-kdinh@apm.com>
References: <1493340847-25720-1-git-send-email-kdinh@apm.com>
Message-ID: <a33cec72-e4ab-60cb-7173-41043f4a9120@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/27/2017 08:54 PM, Khuong Dinh wrote:
> From: Khuong Dinh <kdinh@apm.com>
> 
> This patch makes pci-xgene-msi driver ACPI-aware and provides
> MSI capability for X-Gene v1 PCIe controllers in ACPI boot mode.
> 
> Signed-off-by: Khuong Dinh <kdinh@apm.com>
> Signed-off-by: Duc Dang <dhdang@apm.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
> v2:
>  - Verify with BIOS version 3.06.25 and 3.07.09
> v1:
>  - Initial version


Hoping I just missed it, but was a follow-up (v3) ever provided for
this? It seems this thread ended with the expectation that a v3 would be
provided to address the sequencing issue.

Regards,
-Jon
