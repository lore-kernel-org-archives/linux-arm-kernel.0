From: zhengxing@rock-chips.com (Xing Zheng)
Date: Tue, 1 Mar 2016 17:19:07 +0800
Subject: [PATCH v3 2/3] clk: rockchip: add dt-binding header for rk3399
In-Reply-To: <1456814401-10711-3-git-send-email-jay.xu@rock-chips.com>
References: <1456456341-14282-1-git-send-email-jay.xu@rock-chips.com>
 <1456814401-10711-1-git-send-email-jay.xu@rock-chips.com>
 <1456814401-10711-3-git-send-email-jay.xu@rock-chips.com>
Message-ID: <56D55E8B.6070804@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jay,

On 2016?03?01? 14:40, Jianqun Xu wrote:
> From: Xing Zheng <zhengxing@rock-chips.com>
>
> Add the dt-bindings header for the rk3399, that gets shared between
> the clock controller and the clock references in the dts.
>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
> Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
> ---
> changes in v3:
> - add pmucru definations
>
>   include/dt-bindings/clock/rk3399-cru.h | 716 +++++++++++++++++++++++++++++++++
>   1 file changed, 716 insertions(+)
>   create mode 100644 include/dt-bindings/clock/rk3399-cru.h
>
> diff --git a/include/dt-bindings/clock/rk3399-cru.h b/include/dt-bindings/clock/rk3399-cru.h
> new file mode 100644
> index 0000000..77bb1ec
> --- /dev/null
> +++ b/include/dt-bindings/clock/rk3399-cru.h
> @@ -0,0 +1,716 @@
> +/*
> + * Copyright (c) 2015 Rockchip Electronics Co. Ltd.
The Copyright should be 2016.

Thanks.

-- 
- Xing Zheng
