From: robh@kernel.org (Rob Herring)
Date: Wed, 14 Jun 2017 13:38:44 -0500
Subject: [PATCH v3 3/3] drm/rockchip: dw_hdmi: introduce the pclk for grf
In-Reply-To: <1496992247-10727-1-git-send-email-mark.yao@rock-chips.com>
References: <1496992228-10582-1-git-send-email-mark.yao@rock-chips.com>
 <1496992247-10727-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <20170614183844.hd6ckfhtvn4x3eg2@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 09, 2017 at 03:10:46PM +0800, Mark Yao wrote:
> For RK3399's GRF module, if we want to operate the graphic related grf
> registers, we need to enable the pclk_vio_grf which supply power for VIO
> GRF IOs, so it's better to introduce an optional grf clock in driver.
> 
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
> ---
> Changes in v3: none
> Changes in v2: describe grf on Documentation.
> 
>  .../bindings/display/rockchip/dw_hdmi-rockchip.txt     |  1 +
>  drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c            | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
