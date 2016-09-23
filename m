From: robh@kernel.org (Rob Herring)
Date: Fri, 23 Sep 2016 17:27:05 -0500
Subject: [PATCH v3 4/4] regulator: axp20x: add the AXP813
In-Reply-To: <21ac1fd8ab33185ec2cdb436272f48571695ce54.1474621108.git.moinejf@free.fr>
References: <cover.1474621107.git.moinejf@free.fr>
 <21ac1fd8ab33185ec2cdb436272f48571695ce54.1474621108.git.moinejf@free.fr>
Message-ID: <20160923222705.GA30134@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 23, 2016 at 09:22:41AM +0200, Jean-Francois Moine wrote:
> The X-Powers AXP813 PMIC is close to the AXP803.
> It is used in some Allwinner boards as the Sinovoip BananaPi M3+.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
>  Documentation/devicetree/bindings/mfd/axp20x.txt |   9 +-
>  drivers/mfd/axp20x.c                             |   2 +
>  drivers/regulator/Makefile                       |   2 +-
>  drivers/regulator/axp813.c                       | 229 +++++++++++++++++++++++
>  include/linux/mfd/axp20x.h                       |   1 +
>  5 files changed, 239 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/regulator/axp813.c
> 
> diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
> index 3332d02..62019fb 100644
> --- a/Documentation/devicetree/bindings/mfd/axp20x.txt
> +++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
> @@ -8,11 +8,12 @@ axp221 (X-Powers)
>  axp223 (X-Powers)
>  axp803 (X-Powers)
>  axp809 (X-Powers)
> +axp813 (X-Powers)
>  
>  Required properties:
>  - compatible: "x-powers,axp152", "x-powers,axp202", "x-powers,axp209",
>  	      "x-powers,axp221", "x-powers,axp223", "x-powers,axp803",
> -	      "x-powers,axp806", "x-powers,axp809"
> +	      "x-powers,axp806", "x-powers,axp809", "x-powers,axp813"

Same comment here.

Acked-by: Rob Herring <robh@kernel.org>
