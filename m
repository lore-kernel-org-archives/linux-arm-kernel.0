From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Sun, 18 Mar 2018 21:17:44 +0100
Subject: [PATCH v4 0/9] Initial Allwinner H6 support
In-Reply-To: <20180316140215.28663-1-icenowy@aosc.io>
References: <20180316140215.28663-1-icenowy@aosc.io>
Message-ID: <20180318201744.dw6hnm2vdybaunev@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2018 at 10:02:06PM +0800, Icenowy Zheng wrote:
> This patchset adds initial support for the Allwinner H6 SoC.
> 
> It's quite different from earlier Allwinner SoCs. For example, the
> memory map is refactored, and the CCU is rearranged. It's also the first
> Allwinner SoC with PCI Express interface (although the implementation
> of the PCI Express controller is broken), and the second one with USB
> 3.0 (the first one is A80).
> 
> This patchset adds the most basical support for it, including the main pin
> controller, the main CCU and the basical device tree.
> 
> Icenowy Zheng (9):
>   pinctrl: sunxi: refactor irq related register function to have desc
>   pinctrl: sunxi: introduce IRQ bank conversion function
>   pinctrl: sunxi: change irq_bank_base to irq_bank_map
>   pinctrl: sunxi: add support for the Allwinner H6 main pin controller
>   clk: sunxi-ng: Support fixed post-dividers on NKMP style clocks
>   dt-bindings: add device tree binding for Allwinner H6 main CCU
>   clk: sunxi-ng: add support for the Allwinner H6 CCU
>   arm64: allwinner: h6: add the basical Allwinner H6 DTSI file
>   arm64: allwinner: h6: add support for Pine H64 board

Applied the !pinctrl patches.

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180318/910792dd/attachment.sig>
