From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 20 Jul 2018 17:47:54 +0200
Subject: [PATCH v3 0/2] Add Mediatek X20 Development Board support
In-Reply-To: <1531997690-6040-1-git-send-email-manivannan.sadhasivam@linaro.org>
References: <1531997690-6040-1-git-send-email-manivannan.sadhasivam@linaro.org>
Message-ID: <e0e5575f-345f-47a7-0d37-489fa23d1562@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 19/07/18 12:54, Manivannan Sadhasivam wrote:
> Add devicetree support for Mediatek X20 Development Board by Archermind.
> This board is based on the Deca-Core MT6797 SoC from Mediatek and is
> one of the 96Boards Consumer Edition platform.
> 
> With this devicetree change, board can boot into initramfs.
> 
> More information about this board can be found in 96Boards product page:
> https://www.96boards.org/product/mediatek-x20/
> 

Pushed both to v4.18-next/dts64

Thanks a lot!
Matthias

> Thanks,
> Mani
> 
> Changes in v3:
> 
> * Modified the memory size to 2GB (0x80000000) in board DTS
> 
> Changes in v2:
> 
> * Added documentation for board compatible
> * Dropped vendor documetation patch since it got applied
> 
> Manivannan Sadhasivam (2):
>   dt-bindings: arm: mediatek: Document Mediatek X20 Development Board
>   arm64: dts: Add Mediatek X20 Development Board support
> 
>  Documentation/devicetree/bindings/arm/mediatek.txt |  3 ++
>  arch/arm64/boot/dts/mediatek/Makefile              |  1 +
>  arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts    | 33 ++++++++++++++++++++++
>  3 files changed, 37 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts
> 
