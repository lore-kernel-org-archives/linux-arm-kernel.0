From: robh@kernel.org (Rob Herring)
Date: Thu, 1 Mar 2018 15:43:57 -0600
Subject: [PATCH v4 6/7] arm64: tegra: Add Tegra194 chip device tree
In-Reply-To: <20180220115812.24108-7-mperttunen@nvidia.com>
References: <20180220115812.24108-1-mperttunen@nvidia.com>
 <20180220115812.24108-7-mperttunen@nvidia.com>
Message-ID: <20180301214357.a7wur5izbpk3udky@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 20, 2018 at 01:58:11PM +0200, Mikko Perttunen wrote:
> Add the chip-level device tree, including binding headers, for the
> NVIDIA Tegra194 "Xavier" system-on-chip. Only a small subset of devices
> are initially available, enough to boot to UART console.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
> 
> Notes:
>     v4:
>     - fixed copyright headers according to license-rules.rst
>     - removed comments from clock bindings
>     
>     v3:
>     - added hypervisor-related apertures to GIC node
>     - removed GPL boilerplate in favor of SPDX and harmonized
>       copyright headers
> 
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi       | 344 +++++++++++++++++++++++++
>  include/dt-bindings/clock/tegra194-clock.h     | 321 +++++++++++++++++++++++
>  include/dt-bindings/gpio/tegra194-gpio.h       |  61 +++++
>  include/dt-bindings/power/tegra194-powergate.h |  35 +++
>  include/dt-bindings/reset/tegra194-reset.h     | 152 +++++++++++
>  5 files changed, 913 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/nvidia/tegra194.dtsi
>  create mode 100644 include/dt-bindings/clock/tegra194-clock.h
>  create mode 100644 include/dt-bindings/gpio/tegra194-gpio.h
>  create mode 100644 include/dt-bindings/power/tegra194-powergate.h
>  create mode 100644 include/dt-bindings/reset/tegra194-reset.h

Reviewed-by: Rob Herring <robh@kernel.org>
