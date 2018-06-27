From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 27 Jun 2018 15:10:12 +0200
Subject: [PATCH] drm/rockchip: vop: fixup linebuffer mode calc error
In-Reply-To: <1530001004-25036-1-git-send-email-hjc@rock-chips.com>
References: <1530001004-25036-1-git-send-email-hjc@rock-chips.com>
Message-ID: <2037317.Zy9BHlEm4Q@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sandy,

Am Dienstag, 26. Juni 2018, 10:16:44 CEST schrieb Sandy Huang:
> linebuffer mode should be LB_YUV_3840X5 when width is bigger
> than 1280 in yuv mode.
> seperate yuv and rgb case make the scl_vop_cal_lb_mode() logic
> is clearer.
> 
> Signed-off-by: Sandy Huang <hjc@rock-chips.com>

applied to drm-misc-next


Heiko
