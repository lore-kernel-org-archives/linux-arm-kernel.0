From: zhengxing@rock-chips.com (Xing Zheng)
Date: Tue, 21 Jun 2016 20:12:50 +0800
Subject: [PATCH] net: stmmac: dwmac-rk: add rk322x-specific data
In-Reply-To: <3520853.j0ALyW964u@diego>
References: <1466493235-17789-1-git-send-email-zhengxing@rock-chips.com>
 <3520853.j0ALyW964u@diego>
Message-ID: <57692F42.30709@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On 2016?06?21? 17:43, Heiko St?bner wrote:
> devicetree names are normally expected to be real, aka no "x" as catchall. So
> I guess either just add compatibles for both the rk3228 and rk3229 which point
> to the same structure in the driver. (So driver-side can stay as it is below,
> just add a second compatible).
OK, I try to just use "rockchip,rk3228-gmac" to point to "rk322x_ops" 
which is the same structure in MAC driver,
and both rk3228 and rk3229 use it.

Thanks

-- 
- Xing Zheng
