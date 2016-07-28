From: bp@alien8.de (Borislav Petkov)
Date: Thu, 28 Jul 2016 13:47:56 +0200
Subject: [PATCH 00/10] Add NAND, DMA, USB, and QSPI EDAC
In-Reply-To: <1468512408-5156-1-git-send-email-tthayer@opensource.altera.com>
References: <1468512408-5156-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <20160728114756.GA11218@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 14, 2016 at 11:06:38AM -0500, tthayer at opensource.altera.com wrote:
> From: Thor Thayer <tthayer@opensource.altera.com>
> 
> This patch series adds the NAND, DMA, USB and QSPI FIFO EDAC modules.
> 
> Thor Thayer (10):
>   Documentation: dt: socfpga: Add Arria10 NAND EDAC binding
>   Documentation: dt: socfpga: Add Arria10 DMA EDAC binding
>   Documentation: dt: socfpga: Add Arria10 USB EDAC binding
>   Documentation: dt: socfpga: Add Arria10 QSPI EDAC binding
>   EDAC, altera: Add Arria10 NAND EDAC support
>   EDAC, altera: Add Arria10 DMA EDAC support
>   EDAC, altera: Add Arria10 USB EDAC support
>   EDAC, altera: Add Arria10 QSPI EDAC support
>   ARM: dts: Add Arria10 DMA EDAC devicetree entry
>   ARM: dts: Add Arria10 USB EDAC devicetree entry
> 
>  .../bindings/arm/altera/socfpga-eccmgr.txt         |   79 ++++++++++++
>  arch/arm/boot/dts/socfpga_arria10.dtsi             |   16 +++
>  drivers/edac/Kconfig                               |   28 +++++
>  drivers/edac/altera_edac.c                         |  130 +++++++++++++++++++-
>  4 files changed, 252 insertions(+), 1 deletion(-)

All applied, thanks!

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
