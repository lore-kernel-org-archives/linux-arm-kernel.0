From: pombredanne@nexb.com (Philippe Ombredanne)
Date: Tue, 9 Jan 2018 13:48:24 +0100
Subject: [RFC PATCH] drivers: soc: xilinx: Add ZynqMP power domain driver
In-Reply-To: <1515449572-5398-1-git-send-email-jollys@xilinx.com>
References: <1515449572-5398-1-git-send-email-jollys@xilinx.com>
Message-ID: <CAOFm3uFGuhBzXRrnuaFbdmjXSfq8Gm+Of93e3ovzdTZN1YaF9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jolly,

On Mon, Jan 8, 2018 at 11:12 PM, Jolly Shah <jolly.shah@xilinx.com> wrote:
> The zynqmp-genpd driver communicates the usage requirements
> for logical power domains / devices to the platform FW.
> FW is responsible for choosing appropriate power states,
> taking Linux' usage information into account.
>
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> ---

<snip>

> --- /dev/null
> +++ b/drivers/soc/xilinx/zynqmp/pm_domains.c
> @@ -0,0 +1,343 @@
> +/*
> + * ZynqMP Generic PM domain support
> + *
> + *  Copyright (C) 2014-2017 Xilinx, Inc.
> + *
> + *  Davorin Mista <davorin.mista@aggios.com>
> + *  Jolly Shah <jollys@xilinx.com>
> + *  Rajan Vaja <rajanv@xilinx.com>
> + *
> + * SPDX-License-Identifier:     GPL-2.0+
> + */

This tag should be on the fist line as this:

// SPDX-License-Identifier: GPL-2.0+

-- 
Cordially
Philippe Ombredanne
