From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 29 May 2018 08:38:27 +0200
Subject: [PATCH 0/2] Add Mediatek X20 Development Board support
In-Reply-To: <20180529045258.1415-1-manivannan.sadhasivam@linaro.org>
References: <20180529045258.1415-1-manivannan.sadhasivam@linaro.org>
Message-ID: <06dbc5ef-5bba-f3e0-1b57-3eaeab26ed68@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Manivannan,

it's nice to see that someone at Linaro cares about upstreaming the 96 board.
>From what I can see, your patches add the very same support to the board as
does the mt6797 evaluation board. Do you have plans to upstream more drivers for
the board? Do you have a roadmap or something?

I'm asking becuase I don't want to have just another dead devicetree in the
kernel which does nothing but provides a boot to rootfs. Especially as this can
be achieved on the same board with the EVB dts.

Regards,
Matthias

On 29/05/18 06:52, Manivannan Sadhasivam wrote:
> Add devicetree support for Mediatek X20 Development Board by Archermind.
> This board is based on the Deca-Core MT6797 SoC from Mediatek and is
> one of the 96Boards Consumer Edition platform.
> 
> With this devicetree change, board can boot into initramfs.
> 
> More information about this board can be found in 96Boards product page:
> https://www.96boards.org/product/mediatek-x20/
> 
> Manivannan Sadhasivam (2):
>   dt-bindings: Add vendor prefix for ArcherMind
>   arm64: dts: Add Mediatek X20 Development Board support
> 
>  .../devicetree/bindings/vendor-prefixes.txt   |  1 +
>  arch/arm64/boot/dts/mediatek/Makefile         |  1 +
>  .../boot/dts/mediatek/mt6797-x20-dev.dts      | 33 +++++++++++++++++++
>  3 files changed, 35 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts
> 
