From: ryder.lee@mediatek.com (Ryder Lee)
Date: Thu, 25 May 2017 10:41:10 +0800
Subject: [PATCH v2 0/2] Add PCIe phy driver for some Mediatek SoCs
In-Reply-To: <1495338192-9423-1-git-send-email-ryder.lee@mediatek.com>
References: <1495338192-9423-1-git-send-email-ryder.lee@mediatek.com>
Message-ID: <1495680070.11680.3.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Kishon,

I'd like to rename driver name to make it more generic so that we could
reuse it for other MTK SoCs, and I'll resend patches with a new name.

Sorry for the inconvenience.

Ryder.


On Sun, 2017-05-21 at 11:43 +0800, Ryder Lee wrote:
> Hi,
> 
> This patch series add PCIe phy driver and related dt-binding file for
> Mediatek mt7623 SoCs families.
> 
> Changes since v2:
> - rebase to Linux 4.12-rc1
> 
> Changes since v1:
> - revise binding document:
>   drop 'status' properties.
>   add a description to 'phy-switch' property and add vendor prefix.
> 
> Ryder Lee (2):
>   phy: add PCIe PHY driver for mt7623 SoCs families
>   dt-bindings: phy: Add documentation for Mediatek PCIe PHY
> 
>  .../devicetree/bindings/phy/phy-mt7623-pcie.txt    |  63 +++++
>  drivers/phy/Kconfig                                |   8 +
>  drivers/phy/Makefile                               |   1 +
>  drivers/phy/phy-mt7623-pcie.c                      | 290 +++++++++++++++++++++
>  4 files changed, 362 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-mt7623-pcie.txt
>  create mode 100644 drivers/phy/phy-mt7623-pcie.c
> 
