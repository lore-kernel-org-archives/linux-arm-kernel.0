From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 27 Jul 2017 00:44:09 +0200
Subject: [PATCH v6 1/7] drm/rockchip: vop: initialize registers directly
In-Reply-To: <1501049946-5877-1-git-send-email-mark.yao@rock-chips.com>
References: <1501049930-5794-1-git-send-email-mark.yao@rock-chips.com>
 <1501049946-5877-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <3205727.pYBXLEh47x@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 26. Juli 2017, 14:19:05 CEST schrieb Mark Yao:
> At present we are using init_table to initialize some
> registers, but the Register init table use un-document define,
> it is unreadable, and sometimes we only want to update tiny
> bits, init table method is not friendly, it's diffcult to
> reuse for difference chips.
> 
> To make it clean, initialize registers directly, and drops
> init_table mechanism out.
> 
> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>

on rk3036 and rk3288
Tested-by: Heiko Stuebner <heiko@sntech.de>


Heiko
