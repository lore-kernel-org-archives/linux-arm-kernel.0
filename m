From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 20 May 2015 11:24:15 +0300
Subject: [PATCHv3 00/10] ARM: DRA7: add display support
In-Reply-To: <1430906938-26128-1-git-send-email-tomi.valkeinen@ti.com>
References: <1430906938-26128-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <555C44AF.2040800@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 06/05/15 13:08, Tomi Valkeinen wrote:
> Hi,
> 
> This series adds the arch/arm/ side of the display support for DRA7 (DRA72x,
> DRA74x, AM54xx) SoCs. Also support for HDMI output on x15 and DRA72 EVM boards
> is added.
> 
> This series is v3, and is based on v4.1-rc2. There are no differences to v2,
> except rebased and tested.
> 
>  Tomi
> 
> Tomi Valkeinen (10):
>   arm/dts: dra7xx: add 'ti,set-rate-parent' for dss_dss_clk
>   ARM: DRA7: hwmod: add DMM hwmod description
>   ARM: DRA7: hwmod: set DSS submodule parent hwmods
>   ARM: OMAP: display: change compat names to array
>   ARM: OMAP2+: display: detect DRA7 DSS
>   arm/dts: dra7.dtsi: add DSS support
>   arm/dts: dra72-evm.dts: add HDMI
>   arm/dts: am57xx-beagle-x15.dts: add HDMI
>   arm: dra7: add DESHDCP clock
>   CLK: TI: always enable DESHDCP clock
> 
>  arch/arm/boot/dts/am57xx-beagle-x15.dts   |  81 ++++++++++++++++++++++
>  arch/arm/boot/dts/dra7.dtsi               |  43 ++++++++++++
>  arch/arm/boot/dts/dra72-evm.dts           | 110 ++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/dra72x.dtsi             |  11 +++
>  arch/arm/boot/dts/dra74x.dtsi             |  15 ++++
>  arch/arm/boot/dts/dra7xx-clocks.dtsi      |  11 +++
>  arch/arm/mach-omap2/display.c             |  32 +++++----
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c |  33 +++++++++
>  drivers/clk/ti/clk-7xx.c                  |   8 ++-
>  9 files changed, 328 insertions(+), 16 deletions(-)

Ping. Any comments? Can we get this into the next merge window?

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150520/f16222d0/attachment.sig>
