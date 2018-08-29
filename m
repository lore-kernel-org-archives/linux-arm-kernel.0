From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 29 Aug 2018 14:03:56 +0200
Subject: [PATCH] drm/rockchip: vop: fix some register define error for px30
In-Reply-To: <1535445150-40296-1-git-send-email-hjc@rock-chips.com>
References: <1535445150-40296-1-git-send-email-hjc@rock-chips.com>
Message-ID: <11292257.FZhH7mPKX6@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 28. August 2018, 10:32:30 CEST schrieb Sandy Huang:
> 1. interrupt register define error lead to enable interrupt failed;
> 2. px30 unsupport hdmi output;
> 3. there are some hardware designed bug, we must swap win2 gate and
>    enable offset, otherwise will appear vop iommu pagefault.
> 
> Signed-off-by: Sandy Huang <hjc@rock-chips.com>

applied to drm-misc-next, as the px30 dts support is not part of 4.19
so this will only be an issue for future kernels.


Thanks
Heiko
