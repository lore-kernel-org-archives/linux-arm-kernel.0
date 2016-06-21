From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 21 Jun 2016 16:51:51 +0200
Subject: [PATCH v2] net: stmmac: dwmac-rk: add rk3228-specific data
In-Reply-To: <1466512409-18855-1-git-send-email-zhengxing@rock-chips.com>
References: <1466512409-18855-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <2585964.YhYKyZXPJu@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 21. Juni 2016, 20:33:28 schrieb Xing Zheng:
> Add constants and callback functions for the dwmac on rk3228/rk3229 socs.
> As can be seen, the base structure is the same, only registers and the
> bits in them moved slightly.
> 
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
