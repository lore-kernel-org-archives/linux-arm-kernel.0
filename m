From: hs@denx.de (Heiko Schocher)
Date: Sat, 2 Dec 2017 04:48:27 +0100
Subject: [PATCH 07/12] ARM: dts: imx6qdl-aristainetos: Move display node
 out of 'soc'
In-Reply-To: <1512156285-18451-7-git-send-email-festevam@gmail.com>
References: <1512156285-18451-1-git-send-email-festevam@gmail.com>
 <1512156285-18451-7-git-send-email-festevam@gmail.com>
Message-ID: <16268a9f-aea4-4efc-02d4-37a9a9e2784a@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Fabio,

Am 01.12.2017 um 20:24 schrieb Fabio Estevam:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Move disp0 node from soc node to root node.
> 
> disp0 node does not have any register properties and thus
> shouldn't be placed on the bus.
> 
> This fixes the following build warnings with W=1:
> 
> arch/arm/boot/dts/imx6dl-aristainetos_4.dtb: Warning (simple_bus_reg): Node /soc/disp0 missing or empty reg/ranges property
> 
> Cc: Heiko Schocher <hs@denx.de>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>   arch/arm/boot/dts/imx6dl-aristainetos_4.dts | 50 ++++++++++++++---------------
>   arch/arm/boot/dts/imx6dl-aristainetos_7.dts | 48 +++++++++++++--------------
>   2 files changed, 47 insertions(+), 51 deletions(-)

Thanks for fixing!

Reviewed-by: Heiko Schocher <hs@denx.de>
Tested-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs at denx.de
