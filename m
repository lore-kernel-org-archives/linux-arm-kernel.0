From: robh@kernel.org (Rob Herring)
Date: Sat, 16 Jul 2016 08:47:18 -0500
Subject: [PATCH v1 4/6] drm/rockchip: dw_hdmi: add RK3399 HDMI support
In-Reply-To: <1468235146-29575-1-git-send-email-ykk@rock-chips.com>
References: <1468235079-29152-1-git-send-email-ykk@rock-chips.com>
 <1468235146-29575-1-git-send-email-ykk@rock-chips.com>
Message-ID: <20160716134718.GA3267@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2016 at 07:05:46PM +0800, Yakir Yang wrote:
> RK3399 and RK3288 shared the same HDMI IP controller, only some light
> difference with GRF configure.
> 
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> ---
>  .../devicetree/bindings/display/bridge/dw_hdmi.txt |  1 +
>  .../bindings/display/rockchip/dw_hdmi-rockchip.txt |  3 +-

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/gpu/drm/bridge/dw-hdmi.c                   |  2 +-
>  drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c        | 45 ++++++++++++++++++----
>  include/drm/bridge/dw_hdmi.h                       |  6 +++
>  5 files changed, 48 insertions(+), 9 deletions(-)
