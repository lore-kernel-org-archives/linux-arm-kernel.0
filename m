From: jeffy.chen@rock-chips.com (jeffy)
Date: Thu, 27 Jul 2017 16:42:36 +0800
Subject: [v6,7/7] drm/rockchip: vop: rk3328: fix overlay abnormal
In-Reply-To: <1501049980-6239-1-git-send-email-mark.yao@rock-chips.com>
References: <1501049980-6239-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <5979A77C.6000304@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi mark,

On 07/26/2017 02:19 PM, Mark yao wrote:
> It's a hardware bug, all window's overlay channel reset
> value is same, hardware overlay would be die.
>
> so we must initial difference id for each overlay channel.
>
> The Channel register is supported on all vop will full design.
> Following is the details for this register
> VOP_WIN0_CTRL2
>    bit[7:4] win_rid_win0_cbr
>         axi read id of win0 cbr channel
>    bit[3:0] win_rid_win0_yrgb
>         axi read id of win0 yrgb channel
>
> Signed-off-by: Mark Yao<mark.yao@rock-chips.com>

Reviewed-by: Jeffy Chen <jeffy.chen@rock-chips.com>
