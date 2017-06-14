From: robh@kernel.org (Rob Herring)
Date: Wed, 14 Jun 2017 10:35:21 -0500
Subject: [PATCH v3 2/3] drm/rockchip: dw_hdmi: introduce the VPLL clock
 setting
In-Reply-To: <1496992242-10681-1-git-send-email-mark.yao@rock-chips.com>
References: <1496992228-10582-1-git-send-email-mark.yao@rock-chips.com>
 <1496992242-10681-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <20170614153521.fr75vwkbx65i56jf@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 09, 2017 at 03:10:41PM +0800, Mark Yao wrote:
> For RK3399 HDMI, there is an external clock need for HDMI PHY,
> and it should keep the same clock rate with VOP DCLK.
> 
> VPLL have supported the clock for HDMI PHY, but there is no
> clock divider bewteen VPLL and HDMI PHY. So we need to set the
> VPLL rate manually in HDMI driver.
> 
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
> ---
> Changes in v3: none
> Changes in v2: describe vpll on Documentation.
> 
>  .../bindings/display/rockchip/dw_hdmi-rockchip.txt |  2 +-

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c        | 25 +++++++++++++++++++++-
>  2 files changed, 25 insertions(+), 2 deletions(-)
