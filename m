From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 2 Feb 2018 19:29:58 +0530
Subject: [PATCH v6 19/41] clk: davinci: New driver for TI DA8XX USB PHY
 clocks
In-Reply-To: <1516468460-4908-20-git-send-email-david@lechnology.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <1516468460-4908-20-git-send-email-david@lechnology.com>
Message-ID: <abb566ad-e5fd-a09c-e8b7-695ca7c126fa@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 20 January 2018 10:43 PM, David Lechner wrote:
> diff --git a/include/linux/clk/davinci.h b/include/linux/clk/davinci.h
> index 54ea3ff..04b48b3 100644
> --- a/include/linux/clk/davinci.h
> +++ b/include/linux/clk/davinci.h
> @@ -9,6 +9,9 @@
>  
>  #include <linux/types.h>
>  
> +struct clk;
> +struct regmap;

Its probably better to include clk-provider.h and regmap.h?

Thanks,
Sekhar
