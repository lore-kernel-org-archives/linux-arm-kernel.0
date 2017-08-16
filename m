From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 Aug 2017 23:38:35 +0200
Subject: [GIT PULL] Renesas ARM64 Based SoC DT Updates for v4.14
In-Reply-To: <cover.1501509525.git.horms+renesas@verge.net.au>
References: <cover.1501509525.git.horms+renesas@verge.net.au>
Message-ID: <CAK8P3a1iaMrJ0dvS67uw9Am4CoGbcZQdZw2H7OQ6aabHHWnuxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 31, 2017 at 5:03 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> ----------------------------------------------------------------
> Renesas ARM64 Based SoC DT Updates for v4.14
>
> * Add usb2.0 for R-Car H3 (r8a7795) ES2.0 SoC
>
> * Add R-Car D3 (r8a77995) SoC and Draak board support
>
>   Adds minimal support for the R-Car D3 SoC and the Draak development
>   board, allowing to boot from a ramdisk using a serial console.
>
> * Add Add VC6 clock generator to R-Car H3 (r8a7795)/Salvator-XS board
>
>   The VC6 is an I2C-controlled programmable clock generator, used on the
>   board to provide a display dot clock. Add it to DT.
>
> * Add missing second pair of DMA names to MSIOF nodes to
>   R-Car M3-W (r8a7796) SoC
>
>   MSIOF0 and MSIOF1 are tied to two DMA controllers through two pairs of
>   DMA specifiers.  However, the second pair of corresponding DMA names was
>   missing.
>
> * Add support for the DU to R-Car H3 (r8a7795) SoC
>
>   Add a compatible string and VSP links to the DU node. The H3 ES1.x and H3
>   ES2.0 are compatible save for the links to the VSPs that are described
>   explicitly in DT, so there's no need for a new ES2-specific compatible
>   string.
>
> * Enable HDMI on R-Car H3 (r8a7795) and M3-W (r8a7796) ULCB boards
>
> * Enable DU on R-Car M3-W (r8a7796) Salvator-X board
>
> * Enable I2C for DVFS on R-Car H3 (r8a7795) and M3-W (r8a7796) ULCB boards
>
> * Add Add DRIF support to R-Car H3 (r8a7795) and M3-W (r8a7796) SoCs
>
>   Ramesh Shanmugasundaram says, "R-Car Gen3 DRIF is a SPI like receive only
>   slave device."
>
> * Move CPG_AUDIO_CLK_I from board to soc files
>
>   Geert Uytterhoeven says, "The definition of CPG_AUDIO_CLK_I is
>   SoC-specific, not board-specific."
>
> * Add IMR-LX4 support to R-Car H3 (r8a7795) and M3-W (r8a7796) SoCs
>
>   Sergei Shtylyov says, "The image renderer light extended 4 (IMR-LX4) or
>   the distortion correction engine is a drawing processor with a simple
>   instruction system capable of referencing data on an external memory as
>   2D texture data and performing texture mapping and drawing with respect
>   to any shape that is split into triangular objects."

Pulled into next/dt64, thanks!

       Arnd
