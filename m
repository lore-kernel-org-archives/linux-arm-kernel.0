From: david.wu@rock-chips.com (David.Wu)
Date: Mon, 21 Aug 2017 18:30:22 +0800
Subject: [PATCH v2 3/4] clk: rockchip: rv1108: rename macphy to mac
In-Reply-To: <1503303367-17915-4-git-send-email-zhangqing@rock-chips.com>
References: <1503303367-17915-1-git-send-email-zhangqing@rock-chips.com>
 <1503303367-17915-4-git-send-email-zhangqing@rock-chips.com>
Message-ID: <521d67b9-3598-8781-c2a0-76e7829c9a45@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Elaine,

? 2017/8/21 16:16, Elaine Zhang ??:
> This MAC has no internal phy for rv1108.
> 
> Signed-off-by: Elaine Zhang<zhangqing@rock-chips.com>
> ---
>   drivers/clk/rockchip/clk-rv1108.c      | 12 ++++++------
>   include/dt-bindings/clock/rv1108-cru.h |  6 +++---
>   2 files changed, 9 insertions(+), 9 deletions(-)

Acked-by: David Wu <david.wu@rock-chips.com>

Usually, MAC and PHY are separate, macphy is easy to cause ambiguity, 
and RV1108 SOC does not have integrated ethernet PHY. It is more clear 
to change the name.
