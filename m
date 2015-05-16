From: pebolle@tiscali.nl (Paul Bolle)
Date: Sat, 16 May 2015 13:48:07 +0200
Subject: [V4 PATCH 2/6] arm64 : Introduce support for ACPI _CCA object
In-Reply-To: <1431724994-21601-3-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1431724994-21601-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1431724994-21601-3-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <1431776887.2341.17.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just a nit regarding the commit explanation.

On Fri, 2015-05-15 at 16:23 -0500, Suravee Suthikulpanit wrote:
> From http://www.uefi.org/sites/default/files/resources/ACPI_6.0.pdf,
> section 6.2.17 _CCA states that ARM platforms require ACPI _CCA
> object to be specified for DMA-cabpable devices. This patch introduces
> ACPI_MUST_HAVE_CCA in arm64 Kconfig to specify such requirement.

s/ACPI_MUST_HAVE_CCA/ACPI_CCA_REQUIRED/.

Ie, update the commit explanation to match the change introduced in V2.

> In case _CCA is missing, arm64 would assign dummy_dma_ops
> to disable DMA capability of the device.

Thanks,


Paul Bolle
