From: robh@kernel.org (Rob Herring)
Date: Tue, 31 Jul 2018 13:24:26 -0600
Subject: [PATCH v4 05/10] clk: mediatek: Add dt-bindings for MT8183 clocks
In-Reply-To: <1533015487-60189-6-git-send-email-erin.lo@mediatek.com>
References: <1533015487-60189-1-git-send-email-erin.lo@mediatek.com>
 <1533015487-60189-6-git-send-email-erin.lo@mediatek.com>
Message-ID: <20180731192426.GA8792@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2018 at 01:38:02PM +0800, Erin Lo wrote:
> From: Weiyi Lu <weiyi.lu@mediatek.com>
> 
> Add MT8183 clock dt-bindings, include topckgen, apmixedsys,
> infracfg and subsystem clocks.
> 
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> ---
>  include/dt-bindings/clock/mt8183-clk.h | 413 +++++++++++++++++++++++++++++++++
>  1 file changed, 413 insertions(+)
>  create mode 100644 include/dt-bindings/clock/mt8183-clk.h
> 
> diff --git a/include/dt-bindings/clock/mt8183-clk.h b/include/dt-bindings/clock/mt8183-clk.h
> new file mode 100644
> index 0000000..bacad53
> --- /dev/null
> +++ b/include/dt-bindings/clock/mt8183-clk.h
> @@ -0,0 +1,413 @@
> +/* SPDX-License-Identifier: GPL-2.0

This should be a separate comment from the copyright. Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

> + *
> + * Copyright (c) 2018 MediaTek Inc.
> + * Author: Weiyi Lu <weiyi.lu@mediatek.com>
> + */
