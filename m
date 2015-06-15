From: mars.cheng@mediatek.com (Mars Cheng)
Date: Mon, 15 Jun 2015 11:08:45 +0800
Subject: [Patch 0/2] Add mt6580 basic chip support
In-Reply-To: <1433319533-24803-1-git-send-email-mars.cheng@mediatek.com>
References: <1433319533-24803-1-git-send-email-mars.cheng@mediatek.com>
Message-ID: <1434337725.21703.2.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all

May I know if I miss anything to let this patch be reviewed?
I will do my best to fix the problems.

Thanks a lot.

On Wed, 2015-06-03 at 16:18 +0800, Mars Cheng wrote:
> This series add support to mediatek's new SoC, mt6580, a 4-core CA7.
> Only basic I/O, including interrupt, timer & uart.
> 
> Mars Cheng (2):
>   Document: DT: Add bindings for mediatek MT6580 SoC Platform
>   ARM: dts: mediatek: add mt6580 basic support
> 
>  Documentation/devicetree/bindings/arm/mediatek.txt |   4 +
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/mt6580-evbp1.dts                 |  34 ++++++
>  arch/arm/boot/dts/mt6580.dtsi                      | 130 +++++++++++++++++++++
>  4 files changed, 169 insertions(+)
>  create mode 100644 arch/arm/boot/dts/mt6580-evbp1.dts
>  create mode 100644 arch/arm/boot/dts/mt6580.dtsi
> 
> --
> 1.8.1.1.dirty
> 
