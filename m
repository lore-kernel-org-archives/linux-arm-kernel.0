From: mark.yao@rock-chips.com (Mark yao)
Date: Sat, 10 Sep 2016 11:12:26 +0800
Subject: [PATCH] drm/rockchip: vop: support afbc format for rk3399 vop
In-Reply-To: <1473476852-25707-1-git-send-email-mark.yao@rock-chips.com>
References: <1473474544-16248-3-git-send-email-mark.yao@rock-chips.com>
 <1473476852-25707-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <57D37A1A.6050500@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry, wrong title on this mail, ignore this mail. I had resent it.
On 2016?09?10? 11:07, Mark Yao wrote:
> Rk3399 vop big can support one afbc decoder, the afbc decoder
> can select which overlay window use it.
>
> on vop hardware, we call afbc decoder as afbdc.
>
> afbdc window has some limit:
>    1, not support offset on source buffer.
>    2, if feed non-afbc buffer to afbc decoder, afbc decoder hardware
>       would die, we need take care of using it.
>
> AFBC is a compressed format, means lower bandwidth consume,
> it's useful to improve performance.
>
> Signed-off-by: Mark Yao<mark.yao@rock-chips.com>
> ---


-- 
?ark Yao
