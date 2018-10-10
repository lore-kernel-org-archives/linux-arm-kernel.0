From: JOLLYS@xilinx.com (Jolly Shah)
Date: Wed, 10 Oct 2018 18:40:03 +0000
Subject: [PATCH v4 0/3] drivers: soc: xilinx: Add support for ZynqMP PM
 driver
In-Reply-To: <1536953990-12755-1-git-send-email-jollys@xilinx.com>
References: <1536953990-12755-1-git-send-email-jollys@xilinx.com>
Message-ID: <BL2PR02MB21301ABF94BB130154868CE8B8E00@BL2PR02MB2130.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping for comments


> -----Original Message-----
> From: linux-kernel-owner at vger.kernel.org [mailto:linux-kernel-
> owner at vger.kernel.org] On Behalf Of Jolly Shah
> Sent: Friday, September 14, 2018 12:40 PM
> To: matthias.bgg at gmail.com; andy.gross at linaro.org; shawnguo at kernel.org;
> geert+renesas at glider.be; bjorn.andersson at linaro.org;
> sean.wang at mediatek.com; m.szyprowski at samsung.com; Michal Simek
> <michals@xilinx.com>; robh+dt at kernel.org; mark.rutland at arm.com
> Cc: Rajan Vaja <RAJANV@xilinx.com>; devicetree at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Jolly Shah
> <JOLLYS@xilinx.com>
> Subject: [PATCH v4 0/3] drivers: soc: xilinx: Add support for ZynqMP PM driver
> 
> Add ZynqMP PM driver. PM driver provides power management support for
> ZynqMP.
> 
> This patch series is based on top of Xilinx firmware patch set:
> https://patchwork.kernel.org/cover/10598195/
> 
> v4:
>  - Minor fixes to address v3 review comments
> 
> v3:
>  - Updated DT bindings as per v2 review comments
> 
> v2:
>  - Rebased on top of latest firmware driver patch series
>  - Updated driver to use shared interrupt instead of mailbox
> 
> Rajan Vaja (3):
>   dt-bindings: soc: Add ZynqMP PM bindings
>   firmware: xilinx: Implement ZynqMP power management APIs
>   drivers: soc: xilinx: Add ZynqMP PM driver
> 
>  .../bindings/power/reset/xlnx,zynqmp-power.txt     |  22 +++
>  drivers/firmware/xilinx/zynqmp.c                   |  29 ++++
>  drivers/soc/xilinx/Kconfig                         |  11 ++
>  drivers/soc/xilinx/Makefile                        |   1 +
>  drivers/soc/xilinx/zynqmp_power.c                  | 178 +++++++++++++++++++++
>  include/linux/firmware/xlnx-zynqmp.h               |  20 +++
>  6 files changed, 261 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt
>  create mode 100644 drivers/soc/xilinx/zynqmp_power.c
> 
> --
> 2.7.4
