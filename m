From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 Aug 2017 17:58:03 +0200
Subject: [GIT PULL] Renesas ARM Based SoC Defconfig Updates for v4.14
In-Reply-To: <cover.1501511664.git.horms+renesas@verge.net.au>
References: <cover.1501511664.git.horms+renesas@verge.net.au>
Message-ID: <CAK8P3a3dXC-jt8qDJnC-P13_9hDXseqYji6378_WXThPdvJXWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 31, 2017 at 5:03 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:

> ----------------------------------------------------------------
> Renesas ARM Based SoC Defconfig Updates for v4.14
>
> * Enable DMA for Renesas serial ports
>
>   Geert Uytterhoeven says, "DMA for (H)SCIF(A|B) serial ports on Renesas
>   R-Car Gen2 and RZ/G1 SoCs is considered stable, hence enable it by
>   default.".
>
> * Enable Ethernet AVB
>
>   For the iWave RZ/G1M Q7 SOM
>
> * Replace DRM_RCAR_HDMI by generic bridge options
> * Replace SND_SOC_RSRC_CARD by SND_SIMPLE_SCU_CARD
> * Replace USB_XHCI_RCAR by USB_XHCI_PLATFORM
> * Enable missing PCIE_RCAR dependency
>
>   Defconfig updates for various Kconfig updates covering
>   renamed Kconfig symbols, now missing dependancies and so on.

Pulled into next/defconfig, thanks!

        Arnd
