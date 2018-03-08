From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 8 Mar 2018 16:07:23 +0100
Subject: [PATCH 0/4] dt/bindings & ARM: dts: tegra: updates
In-Reply-To: <20180210013326.27771-1-marcel@ziswiler.com>
References: <20180210013326.27771-1-marcel@ziswiler.com>
Message-ID: <20180308150723.GB13814@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 10, 2018 at 02:33:21AM +0100, Marcel Ziswiler wrote:
> 
> This series fixes the Tegra GMI controller DT/bindings example, a few
> IRQ type definitions, removes some invalid uses of rsvd1 pin muxes on
> Beaver and removes a duplicate pcie-1 node on Venice2.
> 
> 
> Marcel Ziswiler (4):
>   dt/bindings: fix binding examples for tegra gmi controller
>   ARM: dts: tegra: use proper irq type definitions
>   ARM: dts: tegra: beaver: remove invalid uses of rsvd1
>   ARM: dts: tegra: venice2: remove duplicate pcie-1 node
> 
>  .../devicetree/bindings/bus/nvidia,tegra20-gmi.txt |  6 ++--
>  arch/arm/boot/dts/tegra114-dalmore.dts             |  2 +-
>  arch/arm/boot/dts/tegra124-jetson-tk1.dts          |  2 +-
>  arch/arm/boot/dts/tegra124-venice2.dts             |  9 ++----
>  arch/arm/boot/dts/tegra30-apalis.dtsi              |  4 +--
>  arch/arm/boot/dts/tegra30-beaver.dts               | 32 +++++++++++-----------
>  arch/arm/boot/dts/tegra30-colibri-eval-v3.dts      |  2 +-
>  7 files changed, 25 insertions(+), 32 deletions(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180308/ba9934ae/attachment.sig>
