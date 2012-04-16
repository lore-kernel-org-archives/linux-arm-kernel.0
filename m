From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Mon, 16 Apr 2012 08:24:48 +0200
Subject: [PATCH 4/4] ARM: LPC32xx: Device tree support
In-Reply-To: <1334400790-10892-5-git-send-email-stigge@antcom.de>
References: <1334400790-10892-1-git-send-email-stigge@antcom.de>
 <1334400790-10892-5-git-send-email-stigge@antcom.de>
Message-ID: <20120416062444.GD3037@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Roland Stigge wrote:
> This patch adds device tree support for the LPC32xx SoC
> 
> arch/arm/boot/dts/lpc32xx.dtsi: Include for devices based on LPC32xx
> arch/arm/boot/dts/phy3250.dts: Board support for PHYTEC phyCORE-LPC3250
> arch/arm/boot/mach-lpc32xx/irq.c: irq domain conversion
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>
> 
> ---
> 
> Applies to v3.4-rc2 and requires the previously posted lpc32xx driver dt
> patches (Set 1: 1..8 + GPIO patch)
> 
>  Documentation/devicetree/bindings/arm/lpc32xx-mic.txt |   38 ++
>  Documentation/devicetree/bindings/arm/lpc32xx.txt     |    8 
>  arch/arm/Kconfig                                      |    1 
>  arch/arm/boot/dts/lpc32xx.dtsi                        |  303 ++++++++++++++++++
>  arch/arm/boot/dts/phy3250.dts                         |  108 ++++++
>  arch/arm/mach-lpc32xx/Kconfig                         |   26 -
>  arch/arm/mach-lpc32xx/clock.c                         |   77 ++--
>  arch/arm/mach-lpc32xx/common.c                        |  192 -----------
>  arch/arm/mach-lpc32xx/common.h                        |   14 
>  arch/arm/mach-lpc32xx/irq.c                           |   78 +++-
>  arch/arm/mach-lpc32xx/phy3250.c                       |  146 +++-----
>  11 files changed, 613 insertions(+), 378 deletions(-)

This looks like too many unrelated changes for one patch.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120416/82e7d078/attachment.sig>
