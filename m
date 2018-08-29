From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 29 Aug 2018 14:57:13 +0200
Subject: [PATCH] arm64: dts: rockchip: perfection vop property define for
 px30
In-Reply-To: <1535512642-81253-1-git-send-email-hjc@rock-chips.com>
References: <1535512642-81253-1-git-send-email-hjc@rock-chips.com>
Message-ID: <7278966.mqSsajnGxb@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 29. August 2018, 05:17:13 CEST schrieb Sandy Huang:
> Add display ports for display-subsystem and add reset property
> for vop node, if missing this two define, drm driver can't
> probe sucess.
> 
> Signed-off-by: Sandy Huang <hjc@rock-chips.com>

with a bit of cleanup applied for 4.20

Thanks
Heiko
