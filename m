From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 28 Jul 2017 11:21:04 +0200
Subject: [PATCH v6.1 4/7] drm/rockchip: vop: group vop registers
In-Reply-To: <1501221986-29722-1-git-send-email-mark.yao@rock-chips.com>
References: <1501049966-6070-1-git-send-email-mark.yao@rock-chips.com>
 <1501221986-29722-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <2703369.ItVkh0VymE@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 28. Juli 2017, 14:06:25 CEST schrieb Mark Yao:
> Grouping the vop registers facilitates make register
> definition clearer, and also is useful for different vop
> reuse the same group register.
> 
> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
> Reviewed-by: Jeffy Chen <jeffy.chen@rock-chips.com>

on rk3036 and rk3288
Tested-by: Heiko Stuebner <heiko@sntech.de>
