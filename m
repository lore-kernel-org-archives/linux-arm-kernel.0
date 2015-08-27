From: sbranden@broadcom.com (Scott Branden)
Date: Thu, 27 Aug 2015 16:35:30 -0700
Subject: [PATCH v2 0/5] Add Broadcom Northstar Plus Support
In-Reply-To: <1440628530-6137-1-git-send-email-jonmason@broadcom.com>
References: <1440628530-6137-1-git-send-email-jonmason@broadcom.com>
Message-ID: <55DF9EC2.4060902@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patchset all look good.
Acked-by: Scott Branden <sbranden@broadcom.com>

On 15-08-26 03:35 PM, Jon Mason wrote:
>
> Changes in version 2 incorporate Olof's comments regarding:
> * the removal of all "Reviewed-by" lines not occurring on external
>    mailing lists
> * reordering of s-o-b lines
> * modification of the device tree file to use labels when enabling
> * increated description of the modification to the MAINTAINERS entry
>
> Also, modifying the "to" and "cc" recepients so that everyone is
> receving all of the patches.
>
> --
>
> This patch series adds support for the Broadcom Northstar Plus family of
> SoCs.  NSP is a Cortex A9 based SoC under the Broadcom iProc family.
>
> Jon Mason (5):
>    dt-bindings: Create Documentation for NSP DT bindings
>    ARM: NSP: add minimal Northstar Plus device tree
>    ARM: NSP: Add basic support for Broadcom Northstar Plus SoC
>    ARM: multi_v7_defconfig: Add NSP to defconfig
>    MAINTAINERS: add entry for the Broadcom Northstar Plus SoCs
>
>   .../devicetree/bindings/arm/bcm/brcm,nsp.txt       |  34 +++++++
>   MAINTAINERS                                        |  12 ++-
>   arch/arm/boot/dts/Makefile                         |   2 +
>   arch/arm/boot/dts/bcm-nsp.dtsi                     | 105 +++++++++++++++++++++
>   arch/arm/boot/dts/bcm958625k.dts                   |  57 +++++++++++
>   arch/arm/configs/multi_v7_defconfig                |   1 +
>   arch/arm/mach-bcm/Kconfig                          |  14 +++
>   arch/arm/mach-bcm/Makefile                         |   5 +-
>   arch/arm/mach-bcm/bcm_nsp.c                        |  25 +++++
>   9 files changed, 252 insertions(+), 3 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,nsp.txt
>   create mode 100644 arch/arm/boot/dts/bcm-nsp.dtsi
>   create mode 100644 arch/arm/boot/dts/bcm958625k.dts
>   create mode 100644 arch/arm/mach-bcm/bcm_nsp.c
>
