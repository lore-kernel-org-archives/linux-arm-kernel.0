From: robh+dt@kernel.org (Rob Herring)
Date: Thu, 22 Jun 2017 12:04:43 -0500
Subject: [PATCH v3.1 1/3] drm/rockchip: dw_hdmi: add RK3399 HDMI support
In-Reply-To: <1498115845-7177-1-git-send-email-mark.yao@rock-chips.com>
References: <1496992236-10634-1-git-send-email-mark.yao@rock-chips.com>
 <1498115845-7177-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <CAL_JsqKU3u-PNMCeDTgiGULn29wxejWVWOa9rapJCQuvMKZpDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 22, 2017 at 2:17 AM, Mark Yao <mark.yao@rock-chips.com> wrote:
> RK3399 and RK3288 shared the same HDMI IP controller, only some light
> difference with GRF configure.
>
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
> ---
> Changes in v3.1:
>   Correct documentation compatible's format(Rob Herring).
> Changes in v3:
>   remove hdmi_phy_configure_dwc_hdmi_3d_tx callbak.
>
> Changes in v2:
>   reuse hdmi_phy_configure_dwc_hdmi_3d_tx for phy configure
>   fixup Documentation
>
>  .../bindings/display/rockchip/dw_hdmi-rockchip.txt |  4 +-

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c        | 67 ++++++++++++++++++----
>  2 files changed, 59 insertions(+), 12 deletions(-)
