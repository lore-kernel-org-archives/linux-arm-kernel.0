From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 17 Jul 2012 16:59:01 +0200
Subject: [PATCH] [RFC] arm: add documentation describing Marvell families
 of SoC
In-Reply-To: <1342535201-12907-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1342535201-12907-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20120717145901.GQ2489@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2012 at 04:26:41PM +0200, Thomas Petazzoni wrote:
> As stated in the introduction of the document, the families of ARM
> SoCs at Marvell are very complicated, and it is difficult for
> newcomers to understand the organization of this SoC family and how it
> relates to the Linux kernel support for those hardware platforms.
> 
> This document is only at RFC stage for now, it requires reviews and
> comments from the Marvell maintainers, the PXA maintainers and the MMP
> maintainers. For correctness of course, but also to add any other
> information that would be useful. For example, one of the thing that
> wasn't clear how to detail in the documentation is how the SoCs relate
> to each other in terms of hardware IP blocks. For example, most of the
> Kirkwood/Dove/Armada 370-XP/etc. hardware IPs (I2C, SPI, USB, SATA,
> etc.) are identical, while the PXA and MMP families are completely
> separate.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Olof Johansson <olof@lixom.net>
> ---
>  Documentation/arm/Marvell/README |  168 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 168 insertions(+)
>  create mode 100644 Documentation/arm/Marvell/README
> 
> diff --git a/Documentation/arm/Marvell/README b/Documentation/arm/Marvell/README
> new file mode 100644
> index 0000000..4f33433
> --- /dev/null
> +++ b/Documentation/arm/Marvell/README
> @@ -0,0 +1,168 @@
> +ARM Marvell SoCs
> +================
> +
> +This document lists all the ARM Marvell SoCs that are currently
> +supported in mainline by the Linux kernel. As the Marvell families of
> +SoCs are large and complex, it is hard to understand where the support
> +for a particular SoC is available in the Linux kernel. This document
> +tries to help in understanding where those SoCs are supported, and to
> +match them with their corresponding public datasheet, when available.
> +
> +Orion family
> +------------
> +
> +  Flavors:
> +        88F5082
> +        88F5181
> +        88F5181L
> +        88F5182
> +        88F5281
> +        88F6183
> +  Core: ARMv5 compatible
> +  Linux kernel directory: arch/arm/mach-orion5x
> +  No public datasheets available.

There is a MV88F5182-opensource-manual.pdf document. It
can be downloaded from:

www.embeddedarm.com/.../MV88F5182-opensource-manual.pdf

	Andrew
