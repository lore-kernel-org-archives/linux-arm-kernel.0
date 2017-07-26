From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 27 Jul 2017 00:50:51 +0200
Subject: [PATCH v6 3/7] drm/rockchip: vop: move line_flag_num to interrupt
 registers
In-Reply-To: <1501049960-6006-1-git-send-email-mark.yao@rock-chips.com>
References: <1501049930-5794-1-git-send-email-mark.yao@rock-chips.com>
 <1501049960-6006-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1646231.OqT85nW1UI@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 26. Juli 2017, 14:19:19 CEST schrieb Mark Yao:
> In the hardware design process, the design of line flags
> register is associated with the interrupt register,
> placing the line flags in the interrupt definition is
> more reasonable, and it would make multi-vop define easilier.
> 
> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
> Reviewed-by: Sean Paul <seanpaul@chromium.org>

on rk3036 and rk3288
Tested-by: Heiko Stuebner <heiko@sntech.de>


Heiko
