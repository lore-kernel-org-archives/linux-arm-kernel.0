From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 26 Jun 2018 10:22:55 +0200
Subject: [PATCH] drm/rockchip: vop: fixup linebuffer mode calc error
In-Reply-To: <1530001004-25036-1-git-send-email-hjc@rock-chips.com>
References: <1530001004-25036-1-git-send-email-hjc@rock-chips.com>
Message-ID: <61227765.LN80DIZAeb@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 26. Juni 2018, 10:16:44 CEST schrieb Sandy Huang:
> linebuffer mode should be LB_YUV_3840X5 when width is bigger
> than 1280 in yuv mode.
> seperate yuv and rgb case make the scl_vop_cal_lb_mode() logic
> is clearer.
> 
> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
> Link:
> https://patchwork.freedesktop.org/patch/msgid/1523960108-190541-1-git-send-> email-hjc at rock-chips.com

Missing the "v2" in the subject, but I remembered and found the v1 from april. 
And it looks great now.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
