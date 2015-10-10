From: lkp@intel.com (kbuild test robot)
Date: Sat, 10 Oct 2015 22:12:45 +0800
Subject: [PATCH v3] PCI: layerscape: Add PCIe support for LS1043a and
 LS2080a
In-Reply-To: <1444458217-31004-1-git-send-email-Minghuan.Lian@freescale.com>
Message-ID: <201510102219.eCBMRYJD%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Minghuan,

[auto build test ERROR on v4.3-rc4 -- if it's inappropriate base, please ignore]

config: arm64-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All error/warnings (new ones prefixed by >>):

   In file included from drivers/net/fddi/skfp/h/smc.h:50:0,
   from drivers/net/fddi/skfp/drvfbi.c:23:
   drivers/net/fddi/skfp/h/targetos.h:63:0: warning: "FALSE" redefined
   #define FALSE 0
   ^
   In file included from include/acpi/acpi.h:58:0,
   from include/linux/acpi.h:33,
   from arch/arm64/include/asm/dma-mapping.h:21,
   from include/linux/dma-mapping.h:86,
   from include/linux/skbuff.h:34,
   from include/linux/if_ether.h:23,
   from include/uapi/linux/ethtool.h:17,
   from include/linux/ethtool.h:16,
   from include/linux/netdevice.h:42,
   from drivers/net/fddi/skfp/h/targetos.h:47,
   from drivers/net/fddi/skfp/h/smc.h:50,
   from drivers/net/fddi/skfp/drvfbi.c:23:
   include/acpi/actypes.h:433:0: note: this is the location of the previous definition
   #define FALSE (1 == 0)
   ^
   In file included from drivers/net/fddi/skfp/h/smc.h:50:0,
   from drivers/net/fddi/skfp/hwt.c:32:
   drivers/net/fddi/skfp/h/targetos.h:62:0: warning: "TRUE" redefined
   #define TRUE 1
   ^
   In file included from include/acpi/acpi.h:58:0,
   from include/linux/acpi.h:33,
   from arch/arm64/include/asm/dma-mapping.h:21,
   from include/linux/dma-mapping.h:86,
   from include/linux/skbuff.h:34,
   from include/linux/if_ether.h:23,
   from include/uapi/linux/ethtool.h:17,
   from include/linux/ethtool.h:16,
   from include/linux/netdevice.h:42,
   from drivers/net/fddi/skfp/h/targetos.h:47,
   from drivers/net/fddi/skfp/h/smc.h:50,
   from drivers/net/fddi/skfp/hwt.c:32:
   include/acpi/actypes.h:438:0: note: this is the location of the previous definition
   #define TRUE (1 == 1)
   ^
   In file included from drivers/net/fddi/skfp/h/smc.h:50:0,
   from drivers/net/fddi/skfp/hwt.c:32:
   drivers/net/fddi/skfp/h/targetos.h:63:0: warning: "FALSE" redefined
   #define FALSE 0
   ^
   In file included from include/acpi/acpi.h:58:0,
   from include/linux/acpi.h:33,
   from arch/arm64/include/asm/dma-mapping.h:21,
   from include/linux/dma-mapping.h:86,
   from include/linux/skbuff.h:34,
   from include/linux/if_ether.h:23,
   from include/uapi/linux/ethtool.h:17,
   from include/linux/ethtool.h:16,
   from include/linux/netdevice.h:42,
   from drivers/net/fddi/skfp/h/targetos.h:47,
   from drivers/net/fddi/skfp/h/smc.h:50,
   from drivers/net/fddi/skfp/hwt.c:32:
   include/acpi/actypes.h:433:0: note: this is the location of the previous definition
   #define FALSE (1 == 0)
   ^
   In file included from drivers/net/fddi/skfp/h/smc.h:50:0,
   from drivers/net/fddi/skfp/ess.c:38:
   drivers/net/fddi/skfp/h/targetos.h:62:0: warning: "TRUE" redefined
   #define TRUE 1
   ^
   In file included from include/acpi/acpi.h:58:0,
   from include/linux/acpi.h:33,
   from arch/arm64/include/asm/dma-mapping.h:21,
   from include/linux/dma-mapping.h:86,
   from include/linux/skbuff.h:34,
   from include/linux/if_ether.h:23,
   from include/uapi/linux/ethtool.h:17,
   from include/linux/ethtool.h:16,
   from include/linux/netdevice.h:42,
   from drivers/net/fddi/skfp/h/targetos.h:47,
   from drivers/net/fddi/skfp/h/smc.h:50,
   from drivers/net/fddi/skfp/ess.c:38:
   include/acpi/actypes.h:438:0: note: this is the location of the previous definition
   #define TRUE (1 == 1)
   ^
   In file included from drivers/net/fddi/skfp/h/smc.h:50:0,
   from drivers/net/fddi/skfp/ess.c:38:
   drivers/net/fddi/skfp/h/targetos.h:63:0: warning: "FALSE" redefined
   #define FALSE 0
   ^
   In file included from include/acpi/acpi.h:58:0,
   from include/linux/acpi.h:33,
   from arch/arm64/include/asm/dma-mapping.h:21,
   from include/linux/dma-mapping.h:86,
   from include/linux/skbuff.h:34,
   from include/linux/if_ether.h:23,
   from include/uapi/linux/ethtool.h:17,
   from include/linux/ethtool.h:16,
   from include/linux/netdevice.h:42,
   from drivers/net/fddi/skfp/h/targetos.h:47,
   from drivers/net/fddi/skfp/h/smc.h:50,
   from drivers/net/fddi/skfp/ess.c:38:
   include/acpi/actypes.h:433:0: note: this is the location of the previous definition
   #define FALSE (1 == 0)
   ^
>> drivers/pci/host/pcie-designware.c:76:52: warning: 'struct pci_sys_data' declared inside parameter list
   static inline struct pcie_port pci_sys_data
   ^
>> drivers/pci/host/pcie-designware.c:76:52: warning: its scope is only this definition or declaration, which is probably not what you want
   In file included from include/uapi/linux/stddef.h:1:0,
   from include/linux/stddef.h:4,
   from include/uapi/linux/posix_types.h:4,
   from include/uapi/linux/types.h:13,
   from include/linux/types.h:5,
   from include/linux/smp.h:10,
   from include/linux/irq.h:12,
   from drivers/pci/host/pcie-designware.c:14:
   drivers/pci/host/pcie-designware.c: In function 'sys_to_pcie':
>> drivers/pci/host/pcie-designware.c:78:13: error: dereferencing pointer to incomplete type
   BUG_ON(!sys->private_data);
   ^
   include/linux/compiler.h:166:42: note: in definition of macro 'unlikely'
   # define unlikely(x) 0)
   ^
>> drivers/pci/host/pcie-designware.c:78:2: note: in expansion of macro 'BUG_ON'
   BUG_ON(!sys->private_data);
   ^
   drivers/pci/host/pcie-designware.c:80:12: error: dereferencing pointer to incomplete type
   return sys->private_data;
   ^
   drivers/pci/host/pcie-designware.c: In function 'dw_pcie_host_init':
>> drivers/pci/host/pcie-designware.c:530:2: error: invalid use of undefined type 'struct hw_pci'
   dw_pci.nr_controllers = 1;
   ^
   drivers/pci/host/pcie-designware.c:531:2: error: invalid use of undefined type 'struct hw_pci'
   dw_pci.private_data = (void
   ^
>> drivers/pci/host/pcie-designware.c:533:2: error: implicit declaration of function 'pci_common_init_dev'
   pci_common_init_dev(pp->dev, &dw_pci);
   ^
   drivers/pci/host/pcie-designware.c: At top level:
   drivers/pci/host/pcie-designware.c:682:41: warning: 'struct pci_sys_data' declared inside parameter list
   static int dw_pcie_setup(int nr, struct pci_sys_data
   ^
   drivers/pci/host/pcie-designware.c: In function 'dw_pcie_setup':
>> drivers/pci/host/pcie-designware.c:686:7: warning: passing argument 1 of 'sys_to_pcie' from incompatible pointer type
   pp = sys_to_pcie(sys);
   ^
   drivers/pci/host/pcie-designware.c:76:33: note: expected 'struct pci_sys_data but argument is of type 'struct pci_sys_data
   static inline struct pcie_port pci_sys_data
   ^
   drivers/pci/host/pcie-designware.c:689:6: error: dereferencing pointer to incomplete type
   sys->io_offset = global_io_offset - pp->io_bus_addr;
   ^
>> drivers/pci/host/pcie-designware.c:690:3: error: implicit declaration of function 'pci_ioremap_io'
   pci_ioremap_io(global_io_offset, pp->io_base);
   ^
   drivers/pci/host/pcie-designware.c:692:31: error: dereferencing pointer to incomplete type
   pci_add_resource_offset(&sys->resources, &pp->io,
   ^
   drivers/pci/host/pcie-designware.c:693:9: error: dereferencing pointer to incomplete type
   sys->io_offset);
   ^
   drivers/pci/host/pcie-designware.c:696:5: error: dereferencing pointer to incomplete type
   sys->mem_offset = pp->mem.start - pp->mem_bus_addr;
   ^
   drivers/pci/host/pcie-designware.c:697:30: error: dereferencing pointer to incomplete type
   pci_add_resource_offset(&sys->resources, &pp->mem, sys->mem_offset);
   ^
   drivers/pci/host/pcie-designware.c:697:56: error: dereferencing pointer to incomplete type
   pci_add_resource_offset(&sys->resources, &pp->mem, sys->mem_offset);
   ^
   drivers/pci/host/pcie-designware.c:698:23: error: dereferencing pointer to incomplete type
   pci_add_resource(&sys->resources, &pp->busn);
   ^
   drivers/pci/host/pcie-designware.c: At top level:
   drivers/pci/host/pcie-designware.c:703:56: warning: 'struct pci_sys_data' declared inside parameter list
   static struct pci_bus nr, struct pci_sys_data
   ^
   drivers/pci/host/pcie-designware.c: In function 'dw_pcie_scan_bus':
   drivers/pci/host/pcie-designware.c:706:25: warning: passing argument 1 of 'sys_to_pcie' from incompatible pointer type
   struct pcie_port = sys_to_pcie(sys);
   ^
   drivers/pci/host/pcie-designware.c:76:33: note: expected 'struct pci_sys_data but argument is of type 'struct pci_sys_data
   static inline struct pcie_port pci_sys_data
   ^
   drivers/pci/host/pcie-designware.c:708:23: error: dereferencing pointer to incomplete type
   pp->root_bus_nr = sys->busnr;
   ^
   drivers/pci/host/pcie-designware.c:711:43: error: dereferencing pointer to incomplete type
   bus = pci_scan_root_bus_msi(pp->dev, sys->busnr, &dw_pcie_ops,
   ^
   drivers/pci/host/pcie-designware.c:712:19: error: dereferencing pointer to incomplete type
   sys, &sys->resources,
   ^
   drivers/pci/host/pcie-designware.c:715:39: error: dereferencing pointer to incomplete type
   bus = pci_scan_root_bus(pp->dev, sys->busnr, &dw_pcie_ops,
   ^
   drivers/pci/host/pcie-designware.c:716:15: error: dereferencing pointer to incomplete type
   sys, &sys->resources);
   ^
   drivers/pci/host/pcie-designware.c: At top level:
>> drivers/pci/host/pcie-designware.c:739:15: error: variable 'dw_pci' has initializer but incomplete type
   static struct hw_pci dw_pci = {
   ^
>> drivers/pci/host/pcie-designware.c:740:2: error: unknown field 'setup' specified in initializer
   .setup = dw_pcie_setup,
   ^
>> drivers/pci/host/pcie-designware.c:740:2: warning: excess elements in struct initializer
>> drivers/pci/host/pcie-designware.c:740:2: warning: (near initialization for 'dw_pci')
>> drivers/pci/host/pcie-designware.c:741:2: error: unknown field 'scan' specified in initializer
   .scan = dw_pcie_scan_bus,
   ^
   drivers/pci/host/pcie-designware.c:741:2: warning: excess elements in struct initializer
   drivers/pci/host/pcie-designware.c:741:2: warning: (near initialization for 'dw_pci')
>> drivers/pci/host/pcie-designware.c:742:2: error: unknown field 'map_irq' specified in initializer
   .map_irq = dw_pcie_map_irq,
   ^
   drivers/pci/host/pcie-designware.c:742:2: warning: excess elements in struct initializer
   drivers/pci/host/pcie-designware.c:742:2: warning: (near initialization for 'dw_pci')
   drivers/pci/host/pcie-designware.c: In function 'sys_to_pcie':
>> drivers/pci/host/pcie-designware.c:81:1: warning: control reaches end of non-void function
   }
   ^
   cc1: some warnings being treated as errors
   Documentation Makefile Module.symvers System.map arch block certs crypto drivers firmware fs include init ipc kernel lib mm modules.builtin modules.order net scripts security sound source usr virt vmlinux vmlinux.o Error 1
   Target '__build' not remade because of errors.
   Documentation Makefile Module.symvers System.map arch block certs crypto drivers firmware fs include init ipc kernel lib mm modules.builtin modules.order net scripts security sound source usr virt vmlinux vmlinux.o Error 2
   Target '__build' not remade because of errors.
   Documentation Makefile Module.symvers System.map arch block certs crypto drivers firmware fs include init ipc kernel lib mm modules.builtin modules.order net scripts security sound source usr virt vmlinux vmlinux.o Error 2
   drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c: In function 'pm8xxx_gpio_probe':
   drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c:675:17: warning: cast from pointer to integer of different size
   pctrl->npins = (unsigned)of_device_get_match_data(&pdev->dev);
   ^
   drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c: In function 'pm8xxx_mpp_probe':
   drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c:766:17: warning: cast from pointer to integer of different size
   pctrl->npins = (unsigned)of_device_get_match_data(&pdev->dev);
   ^
   drivers/net/ethernet/dec/tulip/winbond-840.c: In function 'init_registers':
   drivers/net/ethernet/dec/tulip/winbond-840.c:910:2: warning: #warning Processor architecture undefined
   #warning Processor architecture undefined
   ^
   drivers/net/ethernet/dec/tulip/tulip_core.c:101:2: warning: #warning Processor architecture undefined!
   #warning Processor architecture undefined!
   ^
   In file included from include/linux/kernel.h:10:0,
   from include/linux/list.h:8,
   from include/linux/kobject.h:20,
   from include/linux/device.h:17,
   from drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c:19:
   drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c: In function 'ipq806x_gmac_probe':
   include/linux/bitops.h:6:19: warning: large integer implicitly truncated to unsigned type
   #define BIT(nr) (1UL << (nr))
   ^
   drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c:80:29: note: in expansion of macro 'BIT'
   #define QSGMII_PHY_CDR_EN BIT(0)
   ^
   drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c:335:9: note: in expansion of macro 'QSGMII_PHY_CDR_EN'
   QSGMII_PHY_CDR_EN |
   ^
   In file included from drivers/staging/ft1000/ft1000-usb/ft1000_debug.c:42:0:
   drivers/staging/ft1000/ft1000-usb/ft1000_usb.h:31:0: warning: "FALSE" redefined
   #define FALSE 0
   ^
   In file included from include/acpi/acpi.h:58:0,
   from include/linux/acpi.h:33,
   from arch/arm64/include/asm/dma-mapping.h:21,
   from include/linux/dma-mapping.h:86,
   from include/linux/skbuff.h:34,
   from include/linux/if_ether.h:23,
   from include/uapi/linux/ethtool.h:17,
   from include/linux/ethtool.h:16,
   from include/linux/netdevice.h:42,
   from drivers/staging/ft1000/ft1000-usb/ft1000_debug.c:37:
   include/acpi/actypes.h:433:0: note: this is the location of the previous definition
   #define FALSE (1 == 0)
   ^
   In file included from drivers/staging/ft1000/ft1000-usb/ft1000_debug.c:42:0:
   drivers/staging/ft1000/ft1000-usb/ft1000_usb.h:32:0: warning: "TRUE" redefined
   #define TRUE 1
   ^
   In file included from include/acpi/acpi.h:58:0,
   from include/linux/acpi.h:33,
   from arch/arm64/include/asm/dma-mapping.h:21,
   from include/linux/dma-mapping.h:86,
   from include/linux/skbuff.h:34,
   from include/linux/if_ether.h:23,
   from include/uapi/linux/ethtool.h:17,
   from include/linux/ethtool.h:16,
   from include/linux/netdevice.h:42,
   from drivers/staging/ft1000/ft1000-usb/ft1000_debug.c:37:
   include/acpi/actypes.h:438:0: note: this is the location of the previous definition
   #define TRUE (1 == 1)
   ^
   In file included from drivers/staging/ft1000/ft1000-usb/ft1000_download.c:15:0:
   drivers/staging/ft1000/ft1000-usb/ft1000_usb.h:31:0: warning: "FALSE" redefined
   #define FALSE 0
   ^
   In file included from include/acpi/acpi.h:58:0,
   from include/linux/acpi.h:33,
   from arch/arm64/include/asm/dma-mapping.h:21,
   from include/linux/dma-mapping.h:86,
   from include/linux/skbuff.h:34,
   from include/linux/if_ether.h:23,
   from include/uapi/linux/ethtool.h:17,
   from include/linux/ethtool.h:16,
   from include/linux/netdevice.h:42,
   from drivers/staging/ft1000/ft1000-usb/ft1000_download.c:11:
   include/acpi/actypes.h:433:0: note: this is the location of the previous definition
   #define FALSE (1 == 0)
   ^
   In file included from drivers/staging/ft1000/ft1000-usb/ft1000_download.c:15:0:
   drivers/staging/ft1000/ft1000-usb/ft1000_usb.h:32:0: warning: "TRUE" redefined
   #define TRUE 1
   ^
   In file included from include/acpi/acpi.h:58:0,
   from include/linux/acpi.h:33,
   from arch/arm64/include/asm/dma-mapping.h:21,
   from include/linux/dma-mapping.h:86,
   from include/linux/skbuff.h:34,
   from include/linux/if_ether.h:23,
   from include/uapi/linux/ethtool.h:17,

vim +78 drivers/pci/host/pcie-designware.c

340cba60 Jingoo Han             2013-06-21   8   *
340cba60 Jingoo Han             2013-06-21   9   * This program is free software; you can redistribute it and/or modify
340cba60 Jingoo Han             2013-06-21  10   * it under the terms of the GNU General Public License version 2 as
340cba60 Jingoo Han             2013-06-21  11   * published by the Free Software Foundation.
340cba60 Jingoo Han             2013-06-21  12   */
340cba60 Jingoo Han             2013-06-21  13  
f342d940 Jingoo Han             2013-09-06 @14  #include <linux/irq.h>
f342d940 Jingoo Han             2013-09-06  15  #include <linux/irqdomain.h>
340cba60 Jingoo Han             2013-06-21  16  #include <linux/kernel.h>
340cba60 Jingoo Han             2013-06-21  17  #include <linux/module.h>
f342d940 Jingoo Han             2013-09-06  18  #include <linux/msi.h>
340cba60 Jingoo Han             2013-06-21  19  #include <linux/of_address.h>
804f57b1 Lucas Stach            2014-03-05  20  #include <linux/of_pci.h>
340cba60 Jingoo Han             2013-06-21  21  #include <linux/pci.h>
340cba60 Jingoo Han             2013-06-21  22  #include <linux/pci_regs.h>
4dd964df Kishon Vijay Abraham I 2014-07-17  23  #include <linux/platform_device.h>
340cba60 Jingoo Han             2013-06-21  24  #include <linux/types.h>
340cba60 Jingoo Han             2013-06-21  25  
4b1ced84 Jingoo Han             2013-07-31  26  #include "pcie-designware.h"
340cba60 Jingoo Han             2013-06-21  27  
340cba60 Jingoo Han             2013-06-21  28  /* Synopsis specific PCIE configuration registers */
340cba60 Jingoo Han             2013-06-21  29  #define PCIE_PORT_LINK_CONTROL		0x710
340cba60 Jingoo Han             2013-06-21  30  #define PORT_LINK_MODE_MASK		(0x3f << 16)
4b1ced84 Jingoo Han             2013-07-31  31  #define PORT_LINK_MODE_1_LANES		(0x1 << 16)
4b1ced84 Jingoo Han             2013-07-31  32  #define PORT_LINK_MODE_2_LANES		(0x3 << 16)
340cba60 Jingoo Han             2013-06-21  33  #define PORT_LINK_MODE_4_LANES		(0x7 << 16)
5b0f0738 Zhou Wang              2015-05-13  34  #define PORT_LINK_MODE_8_LANES		(0xf << 16)
340cba60 Jingoo Han             2013-06-21  35  
340cba60 Jingoo Han             2013-06-21  36  #define PCIE_LINK_WIDTH_SPEED_CONTROL	0x80C
340cba60 Jingoo Han             2013-06-21  37  #define PORT_LOGIC_SPEED_CHANGE		(0x1 << 17)
340cba60 Jingoo Han             2013-06-21  38  #define PORT_LOGIC_LINK_WIDTH_MASK	(0x1ff << 8)
4b1ced84 Jingoo Han             2013-07-31  39  #define PORT_LOGIC_LINK_WIDTH_1_LANES	(0x1 << 8)
4b1ced84 Jingoo Han             2013-07-31  40  #define PORT_LOGIC_LINK_WIDTH_2_LANES	(0x2 << 8)
4b1ced84 Jingoo Han             2013-07-31  41  #define PORT_LOGIC_LINK_WIDTH_4_LANES	(0x4 << 8)
5b0f0738 Zhou Wang              2015-05-13  42  #define PORT_LOGIC_LINK_WIDTH_8_LANES	(0x8 << 8)
340cba60 Jingoo Han             2013-06-21  43  
340cba60 Jingoo Han             2013-06-21  44  #define PCIE_MSI_ADDR_LO		0x820
340cba60 Jingoo Han             2013-06-21  45  #define PCIE_MSI_ADDR_HI		0x824
340cba60 Jingoo Han             2013-06-21  46  #define PCIE_MSI_INTR0_ENABLE		0x828
340cba60 Jingoo Han             2013-06-21  47  #define PCIE_MSI_INTR0_MASK		0x82C
340cba60 Jingoo Han             2013-06-21  48  #define PCIE_MSI_INTR0_STATUS		0x830
340cba60 Jingoo Han             2013-06-21  49  
340cba60 Jingoo Han             2013-06-21  50  #define PCIE_ATU_VIEWPORT		0x900
340cba60 Jingoo Han             2013-06-21  51  #define PCIE_ATU_REGION_INBOUND		(0x1 << 31)
340cba60 Jingoo Han             2013-06-21  52  #define PCIE_ATU_REGION_OUTBOUND	(0x0 << 31)
340cba60 Jingoo Han             2013-06-21  53  #define PCIE_ATU_REGION_INDEX1		(0x1 << 0)
340cba60 Jingoo Han             2013-06-21  54  #define PCIE_ATU_REGION_INDEX0		(0x0 << 0)
340cba60 Jingoo Han             2013-06-21  55  #define PCIE_ATU_CR1			0x904
340cba60 Jingoo Han             2013-06-21  56  #define PCIE_ATU_TYPE_MEM		(0x0 << 0)
340cba60 Jingoo Han             2013-06-21  57  #define PCIE_ATU_TYPE_IO		(0x2 << 0)
340cba60 Jingoo Han             2013-06-21  58  #define PCIE_ATU_TYPE_CFG0		(0x4 << 0)
340cba60 Jingoo Han             2013-06-21  59  #define PCIE_ATU_TYPE_CFG1		(0x5 << 0)
340cba60 Jingoo Han             2013-06-21  60  #define PCIE_ATU_CR2			0x908
340cba60 Jingoo Han             2013-06-21  61  #define PCIE_ATU_ENABLE			(0x1 << 31)
340cba60 Jingoo Han             2013-06-21  62  #define PCIE_ATU_BAR_MODE_ENABLE	(0x1 << 30)
340cba60 Jingoo Han             2013-06-21  63  #define PCIE_ATU_LOWER_BASE		0x90C
340cba60 Jingoo Han             2013-06-21  64  #define PCIE_ATU_UPPER_BASE		0x910
340cba60 Jingoo Han             2013-06-21  65  #define PCIE_ATU_LIMIT			0x914
340cba60 Jingoo Han             2013-06-21  66  #define PCIE_ATU_LOWER_TARGET		0x918
340cba60 Jingoo Han             2013-06-21  67  #define PCIE_ATU_BUS(x)			(((x) & 0xff) << 24)
340cba60 Jingoo Han             2013-06-21  68  #define PCIE_ATU_DEV(x)			(((x) & 0x1f) << 19)
340cba60 Jingoo Han             2013-06-21  69  #define PCIE_ATU_FUNC(x)		(((x) & 0x7) << 16)
340cba60 Jingoo Han             2013-06-21  70  #define PCIE_ATU_UPPER_TARGET		0x91C
340cba60 Jingoo Han             2013-06-21  71  
4b1ced84 Jingoo Han             2013-07-31  72  static struct hw_pci dw_pci;
4b1ced84 Jingoo Han             2013-07-31  73  
73e40850 Bjorn Helgaas          2013-10-09  74  static unsigned long global_io_offset;
340cba60 Jingoo Han             2013-06-21  75  
340cba60 Jingoo Han             2013-06-21 @76  static inline struct pcie_port *sys_to_pcie(struct pci_sys_data *sys)
340cba60 Jingoo Han             2013-06-21  77  {
84a263f3 Lucas Stach            2014-09-05 @78  	BUG_ON(!sys->private_data);
84a263f3 Lucas Stach            2014-09-05  79  
340cba60 Jingoo Han             2013-06-21  80  	return sys->private_data;
340cba60 Jingoo Han             2013-06-21 @81  }
340cba60 Jingoo Han             2013-06-21  82  
a01ef59e Pratyush Anand         2013-12-11  83  int dw_pcie_cfg_read(void __iomem *addr, int where, int size, u32 *val)
340cba60 Jingoo Han             2013-06-21  84  {

:::::: The code at line 78 was first introduced by commit
:::::: 84a263f39403ca3b399af77499876e02e634b00b PCI: designware: Check private_data validity in single place

:::::: TO: Lucas Stach <l.stach@pengutronix.de>
:::::: CC: Bjorn Helgaas <bhelgaas@google.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 45539 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151010/750e64d2/attachment-0001.obj>
