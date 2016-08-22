From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 22 Aug 2016 19:20:20 +0200
Subject: [PATCH v3 4/4] arm: dts: rockchip: add reset node for the exist
 saradc SoCs
In-Reply-To: <1469629447-544-4-git-send-email-wxt@rock-chips.com>
References: <1469629447-544-1-git-send-email-wxt@rock-chips.com>
 <1469629447-544-4-git-send-email-wxt@rock-chips.com>
Message-ID: <2485357.yNPXRzbCnj@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 27. Juli 2016, 22:24:07 CEST schrieb Caesar Wang:
> SARADC controller needs to be reset before programming it, otherwise
> it will not function properly.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>

Acked-by: Heiko Stuebner <heiko@sntech.de>
Cc: <Stable@vger.kernel.org>
