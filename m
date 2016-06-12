From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 12 Jun 2016 09:35:26 +0800
Subject: [PATCH 1/3] ARM: dts: imx7d: create i.MX 7Solo base device tree
In-Reply-To: <20160608023709.32090-2-stefan@agner.ch>
References: <20160608023709.32090-1-stefan@agner.ch>
 <20160608023709.32090-2-stefan@agner.ch>
Message-ID: <20160612013526.GV20243@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2016 at 07:37:07PM -0700, Stefan Agner wrote:
> The i.MX 7 series currently consists of two SoCs: i.MX 7Solo and
> 7Dual. The i.MX 7Solo implements a subset of features available on
> i.MX 7Dual, hence create imx7s.dtsi as the base device tree. The
> i.MX 7Dual's additional features over i.MX 7Solo are:
> - Second Cortex-A7 core
> - Second Gigabit Ethernet controller
> - EPD (Electronc Paper Display, not yet part of the device tree)
> - PCIe (not yet part of the device tree)
> - Additional USB2.0 OTG controller
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  arch/arm/boot/dts/imx7d.dtsi | 923 +++----------------------------------------
>  arch/arm/boot/dts/imx7s.dtsi | 880 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 928 insertions(+), 875 deletions(-)

We should probably have a beforehand patch to rename the file, so that
we can avoid this dramatic diffstat.

Shawn
