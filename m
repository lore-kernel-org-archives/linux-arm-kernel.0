From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 20 Nov 2018 17:30:34 +0000
Subject: [PATCHv4 0/3] dts: Add the property of IB and OB
In-Reply-To: <20171110034847.17891-1-xiaowei.bao@nxp.com>
References: <20171110034847.17891-1-xiaowei.bao@nxp.com>
Message-ID: <20181120173021.GA29331@e107981-ln.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 10, 2017 at 11:48:44AM +0800, Bao Xiaowei wrote:
> Depend on http://patchwork.ozlabs.org/patch/815382/
> 
> Bao Xiaowei (3):
>   ARMv8: dts: ls1046a: add the property of IB and OB
>   ARMv8: layerscape: add the pcie ep function support
>   ARMv8: pcie: make the DWC EP driver support for layerscape
> 
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi |   6 ++
>  drivers/pci/dwc/Kconfig                        |   1 +
>  drivers/pci/dwc/pci-layerscape.c               | 121 +++++++++++++++++++++++--
>  3 files changed, 121 insertions(+), 7 deletions(-)

Can I drop this series from the linux-pci patch queue ? I reckon
it is superseded by:

https://patchwork.ozlabs.org/patch/992928/

but I wanted to make sure that's the case, I really can't follow
the version numbering so I am asking.

Thanks,
Lorenzo
