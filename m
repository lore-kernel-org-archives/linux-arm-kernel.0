From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 4 Sep 2014 17:21:48 -0300
Subject: [PATCH 2/2] PCI: Layerscape: Add Layerscape PCIe driver
In-Reply-To: <1409856338-1730-2-git-send-email-Minghuan.Lian@freescale.com>
References: <1409856338-1730-1-git-send-email-Minghuan.Lian@freescale.com>
 <1409856338-1730-2-git-send-email-Minghuan.Lian@freescale.com>
Message-ID: <CAOMZO5BtOO42sde_Eco2=p06WQsJn3+1J44k6i+Dg7qxOK8qdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 4, 2014 at 3:45 PM, Minghuan Lian
<Minghuan.Lian@freescale.com> wrote:
> Add support for Freescale Layerscape PCIe controller. This driver
> re-uses the designware core code.

It seems that this is the same IP as on mx6, right?

Is it possible to adapt drivers/pci/host/pci-imx6.c to work on Layerscape?

> +#define PCIE_LS1021A_BASE      0x3400000
> +#define PCIE_LS1021A_REG_SIZE  0x0100000

You should retrieve base and reg size from the dtsi file.
