From: james.morse@arm.com (James Morse)
Date: Thu, 04 Jun 2015 14:23:47 +0100
Subject: [PATCH v2 3/4] PCI: hisi: Add PCIe host support for Hisilicon
 Soc Hip05
In-Reply-To: <1433320542-49576-4-git-send-email-wangzhou1@hisilicon.com>
References: <1433320542-49576-1-git-send-email-wangzhou1@hisilicon.com>
 <1433320542-49576-4-git-send-email-wangzhou1@hisilicon.com>
Message-ID: <55705163.3070201@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/15 09:35, Zhou Wang wrote:
> diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
> new file mode 100644
> index 0000000..2a4d72e
> --- /dev/null
> +++ b/drivers/pci/host/pcie-hisi.c

New file? Please update MAINTAINERS.
(Also add your new Documentation file in patch 4/4 with that patch)


Thanks,

James
