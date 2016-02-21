From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 21 Feb 2016 01:03:47 +0100
Subject: [PATCH v5 1/8] ARM: dts: rockchip: add hdmi/vop device node for
 rk3036
In-Reply-To: <1454384453-7127-1-git-send-email-wxt@rock-chips.com>
References: <1454384032-6794-1-git-send-email-wxt@rock-chips.com>
 <1454384453-7127-1-git-send-email-wxt@rock-chips.com>
Message-ID: <6774166.XfKvalhQ7F@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 2. Februar 2016, 11:40:50 schrieb Caesar Wang:
> This patch adds the needed display info for rk3036 SOCs.
> 
> The rk3036 support two overlay plane and one hwc plane,
> it supports IOMMU, and its IOMMU same as rk3288's.
> Meanwhile, add the inno hdmi for HDMI display.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>

I've split this into 3 patches (vop, hdmi, kylin enablement) and applied 
this to my dts32 branch.


Heiko
