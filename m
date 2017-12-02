From: hs@denx.de (Heiko Schocher)
Date: Sat, 2 Dec 2017 04:47:44 +0100
Subject: [PATCH 06/12] ARM: dts: imx6qdl-aristainetos: Move regulators out
 of simple-bus
In-Reply-To: <1512156285-18451-6-git-send-email-festevam@gmail.com>
References: <1512156285-18451-1-git-send-email-festevam@gmail.com>
 <1512156285-18451-6-git-send-email-festevam@gmail.com>
Message-ID: <cddb61fa-2662-3ed4-cf0d-71b9c5afd2e0@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello fabio,

Am 01.12.2017 um 20:24 schrieb Fabio Estevam:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> It is not recommended to place regulator nodes inside simple-bus, so
> move them out in order to fix the following build warnings with W=1:
> 
> arch/arm/boot/dts/imx6dl-aristainetos_4.dtb: Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name

This is not fixed through this patch.

> arch/arm/boot/dts/imx6dl-aristainetos_4.dtb: Warning (unit_address_vs_reg): Node /regulators/regulator at 0 has a unit name, but no reg property
> arch/arm/boot/dts/imx6dl-aristainetos_4.dtb: Warning (unit_address_vs_reg): Node /regulators/regulator at 1 has a unit name, but no reg property
> arch/arm/boot/dts/imx6dl-aristainetos_4.dtb: Warning (unit_address_vs_reg): Node /regulators/regulator at 2 has a unit name, but no reg property
> arch/arm/boot/dts/imx6dl-aristainetos_4.dtb: Warning (unit_address_vs_reg): Node /regulators/regulator at 3 has a unit name, but no reg property
> 
> Cc: Heiko Schocher <hs@denx.de>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>   arch/arm/boot/dts/imx6qdl-aristainetos.dtsi  | 73 +++++++++++++-------------
>   arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi | 76 +++++++++++++---------------
>   2 files changed, 70 insertions(+), 79 deletions(-)

Beside of the nitpick, Thanks for fixing!

Reviewed-by: Heiko Schocher <hs@denx.de>
Tested-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs at denx.de
