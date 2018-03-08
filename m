From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 8 Mar 2018 16:19:29 +0100
Subject: [PATCH 0/6] ARM: dts: tegra: apalis-tk1: updates incl. v1.2
 hardware support
In-Reply-To: <20180210013806.28496-1-marcel@ziswiler.com>
References: <20180210013806.28496-1-marcel@ziswiler.com>
Message-ID: <20180308151929.GE13814@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 10, 2018 at 02:38:00AM +0100, Marcel Ziswiler wrote:
> 
> This series sets critical trips, activates PWM pin muxing for PWM3,
> adds a missing AS3722 GPIO0 configuration, adds a hog group for
> Ethernet, PCIe, reset GPIOs, updates the copyright period, removes
> spurious newlines and adds support for the V1.2 hardware revision of
> the Toradex Apalis TK1 system on module.
> 
> 
> Marcel Ziswiler (6):
>   arm: tegra: apalis-tk1: set critical trips
>   ARM: dts: tegra: apalis-tk1: activate pwm pin muxing for pwm3
>   ARM: dts: tegra: apalis-tk1: add missing as3722 gpio0 configuration
>   ARM: dts: tegra: apalis-tk1: hog group for ethernet, pcie, reset gpios
>   ARM: dts: tegra: apalis-tk1: copyright period, spurious newlines
>   ARM: dts: tegra: apalis-tk1: support v1.2 hardware revision
> 
>  arch/arm/boot/dts/Makefile                      |    1 +
>  arch/arm/boot/dts/tegra124-apalis-eval.dts      |   16 +-
>  arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts |  250 +++
>  arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi     | 2052 +++++++++++++++++++++++
>  arch/arm/boot/dts/tegra124-apalis.dtsi          |   70 +-
>  5 files changed, 2344 insertions(+), 45 deletions(-)
>  create mode 100644 arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts
>  create mode 100644 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180308/0c874d84/attachment-0001.sig>
