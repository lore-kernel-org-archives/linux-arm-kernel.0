From: mpfj-list@newflow.co.uk (Mark Jackson)
Date: Wed, 17 Jul 2013 13:08:02 +0100
Subject: [PATCH v2] ARM: dts: add AM33XX MMC support
In-Reply-To: <1372303956-30208-1-git-send-email-joelf@ti.com>
References: <1372303956-30208-1-git-send-email-joelf@ti.com>
Message-ID: <51E68922.5020503@newflow.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/06/13 04:32, Joel Fernandes wrote:
> From: Matt Porter <mporter@ti.com>
> 
> Adds AM33XX MMC support for am335x-bone, am335x-evm, and am335x-evmsk.
> Also added is the DMA binding definitions based on the generic DMA
> request binding.
> 
> The HWMOD data removal was breaking MMC so some new properties like reg,
> interrupt etc were added.
> 
> Changes to DTS:
> Interrupt and reg added by: Joel Fernandes <joelf@ti.com>
> Compatible added by Balaji TK <balajitk@ti.com>
> ti,needs-special-hs-handling added by Gururaja Hebbar <gururaja.hebbar@ti.com>
> 
> Signed-off-by: Matt Porter <mporter@ti.com>
> Acked-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Joel Fernandes <joelf@ti.com>
> ---
>  .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   26 +++++++++++++-
>  arch/arm/boot/dts/am335x-bone.dts                  |    7 ++++
>  arch/arm/boot/dts/am335x-evm.dts                   |    7 ++++
>  arch/arm/boot/dts/am335x-evmsk.dts                 |    7 ++++
>  arch/arm/boot/dts/am33xx.dtsi                      |   38 ++++++++++++++++++++
>  5 files changed, 84 insertions(+), 1 deletion(-)

Excuse my ignorance, but which git repository is this against ?
