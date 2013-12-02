From: monstr@monstr.eu (Michal Simek)
Date: Mon, 02 Dec 2013 20:42:56 +0100
Subject: [PATCH v3 1/2] mmc: arasan: Add driver for Arasan SDHCI
In-Reply-To: <1386007357-11956-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1386007357-11956-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <529CE2C0.5070401@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/02/2013 07:02 PM, Soren Brinkmann wrote:
> Add a driver for Arasan's SDHCI controller core.
> 
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> Acked-by: Rob Herring <rob.herring@calxeda.com> [binding]
> ---
> As discussed, I left binding and license header as is and fixed the typos.
> 
> v3:
>  - fix typo in binding documentation
>  - add missing '>' in MODULE_AUTHOR string
> v2:
>  - document 'interrupts' and 'interrupt-parent' properties in the driver
>    bindings
>  - append '-8.9a' IP version specifier to comaptibility string
> 
>    	Thanks,
> 	S?ren
> 
>  .../devicetree/bindings/mmc/arasan,sdhci.txt       |  27 +++
>  MAINTAINERS                                        |   1 +
>  drivers/mmc/host/Kconfig                           |  12 ++
>  drivers/mmc/host/Makefile                          |   1 +
>  drivers/mmc/host/sdhci-of-arasan.c                 | 224 +++++++++++++++++++++
>  5 files changed, 265 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>  create mode 100644 drivers/mmc/host/sdhci-of-arasan.c

Acked-by: Michal Simek <monstr@monstr.eu>

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131202/67fc9b04/attachment.sig>
