From: khilman@kernel.org (Kevin Hilman)
Date: Fri, 13 Nov 2015 07:59:04 -0800
Subject: [PATCH] soc: Mediatek: Enable SCPSYS power domain driver by
 default
In-Reply-To: <1447411835-19035-1-git-send-email-eddie.huang@mediatek.com>
 (Eddie Huang's message of "Fri, 13 Nov 2015 18:50:35 +0800")
References: <1447411835-19035-1-git-send-email-eddie.huang@mediatek.com>
Message-ID: <7h4mgpdh6f.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eddie Huang <eddie.huang@mediatek.com> writes:

> If enable Mediatek 8173 SoC, it should also enable power domain
> driver. Otherwise access clk subsystem register will fail.
>
> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>

Tested-by: Kevin Hilman <khilman@linaro.org>

This gets the mt8173-evb booting again with arm-soc/for-next and
mainline for me.

I'll let Matthias queue this up and send it with any other fixes for
v4.4-rc1.

Thanks for the fix,

Kevin

P.S. it's curious that nobody caught this basic boot failure before.  Is
nobody else testing mainline on this board?  or maybe not using the
upstream defconfig?
