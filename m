From: robherring2@gmail.com (Rob Herring)
Date: Tue, 26 Mar 2013 16:33:21 -0500
Subject: [PATCH 4/6] pci: Add PCIe driver for Samsung Exynos
In-Reply-To: <00c301ce277b$f2790080$d76b0180$%han@samsung.com>
References: <00c001ce277b$92b26ab0$b8174010$%han@samsung.com>
 <00c301ce277b$f2790080$d76b0180$%han@samsung.com>
Message-ID: <51521421.9020906@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/22/2013 11:07 PM, Jingoo Han wrote:
> Exynos5440 has a PCIe controller which can be used as Root Complex.
> This driver supports a PCIe controller as Root Complex mode.
> 
> Signed-off-by: Surendranath Gurivireddy Balla <suren.reddy@samsung.com>
> Signed-off-by: Siva Reddy Kallam <siva.kallam@samsung.com>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  .../devicetree/bindings/pci/exynos-pcie.txt        |   56 +
>  drivers/pci/host/Kconfig                           |    5 +
>  drivers/pci/host/Makefile                          |    1 +
>  drivers/pci/host/pci-exynos.c                      | 1139 ++++++++++++++++++++
>  4 files changed, 1201 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/exynos-pcie.txt
>  create mode 100644 drivers/pci/host/Makefile
>  create mode 100644 drivers/pci/host/pci-exynos.c

[...]

> +
> +/* synopsis specific PCIE configuration registers*/

If this is a standard IP block, then the driver naming should reflect
that. I suspect there are several others with the same IP block.

Rob
