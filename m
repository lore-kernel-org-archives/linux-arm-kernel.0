From: davem@davemloft.net (David Miller)
Date: Fri, 20 Apr 2018 10:50:04 -0400 (EDT)
Subject: [PATCH net-next v2 0/3] ave: fix the activation issues for
 some UniPhier SoCs
In-Reply-To: <1524122695-19597-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1524122695-19597-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <20180420.105004.1091571122033406428.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Date: Thu, 19 Apr 2018 16:24:52 +0900

> This add the following stuffs to fix the activation issues and satisfy
> requirements for AVE ethernet driver implemented on some UniPhier SoCs.
> 
> - Add support for additional necessary clocks and resets, because the kernel
>   is stalled on Pro4 due to lack of them.
> 
> - Check whether the SoC supports the specified phy-mode
> 
> - Add DT property support indicating system controller that has the feature
>   for configurating phy-mode including built-in phy on LD11.
> 
> v1: https://www.spinics.net/lists/netdev/msg494904.html
> 
> Changes since v1:
> - Add 'Reviewed-by' lines

Series applied to net-next, thank you.
