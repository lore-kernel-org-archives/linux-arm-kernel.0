From: mark.yao@rock-chips.com (Mark yao)
Date: Thu, 24 Dec 2015 08:55:36 +0800
Subject: [PATCH v6.3 4/6] drm: rockchip: Support Synopsys DW MIPI DSI
In-Reply-To: <1450842215-10883-1-git-send-email-zyw@rock-chips.com>
References: <1450260616-21160-5-git-send-email-zyw@rock-chips.com>
 <1450842215-10883-1-git-send-email-zyw@rock-chips.com>
Message-ID: <567B4288.40207@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?12?23? 11:43, Chris Zhong wrote:
> Add support for Synopsys DesignWare MIPI DSI controller which is
> embedded in the rk3288 SoCs.
>
> Signed-off-by: Chris Zhong<zyw@rock-chips.com>
> ---
>
> Changes in v6.3:
> - move the mipi_en gate to ockchip_drm_crtc_mode_config
>
> Changes in v6.2:
> - Remove the atomic feature check (Mark Yao)
>
> Changes in v6.1:
> - Add atomic API support (Heiko St?bne)
>
> Changes in v6:
> - Do not use bridge driver (Thierry Reding)
> - Optimization the phy init sequence
>
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
>
>   drivers/gpu/drm/rockchip/Kconfig            |   10 +
>   drivers/gpu/drm/rockchip/Makefile           |    1 +
>   drivers/gpu/drm/rockchip/dw-mipi-dsi.c      | 1196 +++++++++++++++++++++++++++
>   drivers/gpu/drm/rockchip/rockchip_drm_vop.c |    3 +
>   4 files changed, 1210 insertions(+)
>   create mode 100644 drivers/gpu/drm/rockchip/dw-mipi-dsi.c

looks good for me, and it support atomic API, So
Acked-by: Mark Yao <mark.yao@rock-chips.com>

-- 
?ark Yao
