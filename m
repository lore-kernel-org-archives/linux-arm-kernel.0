From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 10 Nov 2015 12:42:21 +0100
Subject: [PATCH] drm/rockchip: vop: fix window origin calculation
In-Reply-To: <1447149550-18595-1-git-send-email-mark.yao@rock-chips.com>
References: <1447149550-18595-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1671071.tld3k90Oeo@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 10. November 2015, 17:59:10 schrieb Mark Yao:
> From: Dominik Behr <dbehr@chromium.org>
> 
> VOP_WINx_DSP_ST does not require subtracting 1 from the values written to
> it. It actually causes the screen to be shifted by one pixel.
> 
> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>

funny I never noticed that shift, but now that you mention it, I see it too
on my Chromebook and the patch fixes this. I've also looked up the
matching data in the TRM, so

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Heiko Stuebner <heiko@sntech.de>


Heiko
