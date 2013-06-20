From: jg1.han@samsung.com (Jingoo Han)
Date: Thu, 20 Jun 2013 18:59:46 +0900
Subject: [PATCH V7 1/4] pci: Add PCIe driver for Samsung Exynos
In-Reply-To: <00cb01ce6d99$0e932030$2bb96090$@samsung.com>
References: <00cb01ce6d99$0e932030$2bb96090$@samsung.com>
Message-ID: <00cf01ce6d9c$e5870540$b0950fc0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, June 20, 2013 6:32 PM, Jingoo Han wrote:
> 
> Exynos5440 has a PCIe controller which can be used as Root Complex.
> This driver supports a PCIe controller as Root Complex mode.
> 
> Signed-off-by: Surendranath Gurivireddy Balla <suren.reddy@samsung.com>
> Signed-off-by: Siva Reddy Kallam <siva.kallam@samsung.com>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  .../devicetree/bindings/pci/exynos-pcie.txt        |   71 ++
>  drivers/pci/host/Kconfig                           |    5 +
>  drivers/pci/host/Makefile                          |    1 +
>  drivers/pci/host/pci-exynos.c                      | 1057 ++++++++++++++++++++
>  4 files changed, 1134 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/exynos-pcie.txt
>  create mode 100644 drivers/pci/host/pci-exynos.c

Dear Bjorn Helgass,

Would you review this patch?
I have posted the Exynos PCIe patch for about 4 months.
But, I have not received your reply.
I need your feedback. :)
Thank you.

Best regards,
Jingoo Han
