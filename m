From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Feb 2016 15:28:56 +0100
Subject: [PATCH] pci: xgene: Add ECAM fixups
In-Reply-To: <1455068984-22210-1-git-send-email-dhdang@apm.com>
References: <1455068984-22210-1-git-send-email-dhdang@apm.com>
Message-ID: <2994764.UGKJE3zfLx@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 February 2016 17:49:44 Duc Dang wrote:
> X-Gene PCIe controller does not fully support ECAM.
> This patch adds required ECAM fixup to allow X-Gene
> PCIe controller to be functional in ACPI boot mode.
> 
> This patch is based on the original work of
> Mark Salter <msalter@redhat.com> and depends on
> Tomasz's PCIe ACPI series:
> https://lkml.org/lkml/2016/2/4/646
> 
> Signed-off-by: Duc Dang <dhdang@apm.com>
> ---

This really has nothing to do with the PCI host device driver, please
keep it in a separate file in drivers/acpi/.

	Arnd
