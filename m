From: zyw@rock-chips.com (Chris Zhong)
Date: Wed, 8 Mar 2017 10:45:41 +0800
Subject: [PATCH 0/3] RK3399 cdd-dp patches
In-Reply-To: <1488940077-22297-1-git-send-email-zyw@rock-chips.com>
References: <1488940077-22297-1-git-send-email-zyw@rock-chips.com>
Message-ID: <58BF7055.3070207@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Oh, a slip of the finger :(, the headline should be "RK3399 cdn-dp patches"

On 03/08/2017 10:27 AM, Chris Zhong wrote:
> Hi all
> This series is to correct some mistakes in clk_get_rate and the register
> address. And in order to better develop, adding more prints.
>
>
> Chris Zhong (3):
>    drm/rockchip: cdn-dp: return error code when clk_get_rate failed
>    drm/rockchip: cdn-dp: Correct PHY register address
>    drm/rockchip: cdn-dp: add more log for video config
>
>   drivers/gpu/drm/rockchip/cdn-dp-core.c |  5 +++--
>   drivers/gpu/drm/rockchip/cdn-dp-reg.c  |  6 +++++-
>   drivers/gpu/drm/rockchip/cdn-dp-reg.h  | 13 ++++++-------
>   3 files changed, 14 insertions(+), 10 deletions(-)
>

-- 
Chris Zhong
