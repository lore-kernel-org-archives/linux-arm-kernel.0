From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 07 Jun 2018 09:56:58 +0200
Subject: [PATCH v1 2/4] clk: rockchip: add dt-binding header for px30
In-Reply-To: <1528340786-462-3-git-send-email-zhangqing@rock-chips.com>
References: <1528340786-462-1-git-send-email-zhangqing@rock-chips.com>
 <1528340786-462-3-git-send-email-zhangqing@rock-chips.com>
Message-ID: <2233320.o0OUWNYjTa@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 7. Juni 2018, 05:06:24 CEST schrieb Elaine Zhang:
> Add the dt-bindings header for the px30, that gets shared between
> the clock controller and the clock references in the dts.
> Add softreset ID for px30.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  include/dt-bindings/clock/px30-cru.h | 402
> +++++++++++++++++++++++++++++++++++ 1 file changed, 402 insertions(+)
>  create mode 100644 include/dt-bindings/clock/px30-cru.h
> 
> diff --git a/include/dt-bindings/clock/px30-cru.h
> b/include/dt-bindings/clock/px30-cru.h new file mode 100644
> index 000000000000..db9fc2a0bb21
> --- /dev/null
> +++ b/include/dt-bindings/clock/px30-cru.h
> @@ -0,0 +1,402 @@
> +/*
> + * Copyright (c) 2017 Rockchip Electronics Co. Ltd.
> + * Author: Elaine <zhangqing@rock-chips.com>

				^^ full name maybe?

Otherwise looks good.


Heiko
