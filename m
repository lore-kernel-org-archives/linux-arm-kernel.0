From: zhengxing@rock-chips.com (Xing Zheng)
Date: Sun, 7 Aug 2016 17:20:33 +0800
Subject: [PATCH 2/3] dmaengine: pl330: enable burst mode by parsing dt
In-Reply-To: <1470365602-32586-3-git-send-email-shawn.lin@rock-chips.com>
References: <1470365602-32586-1-git-send-email-shawn.lin@rock-chips.com>
 <1470365602-32586-3-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <57A6FD61.6080003@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On 2016?08?05? 10:53, Shawn Lin wrote:
> Currently pl330 use single mode defaultly. But burst
> mode can improve efficiency of memory accessing. We
> couldn't enable it by defalut in case of breaking any
> Socs which don't support it.
>
> With burst mode supported, we could see the improvement
> significantly when tesing SPI transfer etc.
>
> default single mode
> [   88.292550] spi write 65536*1 cost 32402us speed:2022KB/S
>
> After applied with burst mode(len 16)
> [   17.625296] spi write 65536*1 cost 17830us speed:3675KB/S
>
> Cc: Huibin Hong <huibin.hong@rock-chips.com>
> Cc: Xing Zheng <zhengxing@rock-chips.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>
Tested-by: Xing Zheng <zhengxing@rock-chips.com>

Thanks

-- 
- Xing Zheng
