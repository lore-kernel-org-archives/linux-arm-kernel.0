From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 22 Aug 2016 19:19:55 +0200
Subject: [PATCH v3 3/4] arm64: dts: rockchip: add reset saradc node for
 rk3368 SoCs
In-Reply-To: <1469629447-544-3-git-send-email-wxt@rock-chips.com>
References: <1469629447-544-1-git-send-email-wxt@rock-chips.com>
 <1469629447-544-3-git-send-email-wxt@rock-chips.com>
Message-ID: <1802628.7aG4jhMeVI@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 27. Juli 2016, 22:24:06 CEST schrieb Caesar Wang:
> SARADC controller needs to be reset before programming it, otherwise
> it will not function properly.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>

Acked-by: Heiko Stuebner <heiko@sntech.de>
Cc: <Stable@vger.kernel.org>
