From: robh@kernel.org (Rob Herring)
Date: Tue, 22 May 2018 12:13:45 -0500
Subject: [PATCH v3 6/6] drm/rockchip: dw_hdmi: add dw-hdmi support for
 the rk3328
In-Reply-To: <20180515134736.5824-7-heiko@sntech.de>
References: <20180515134736.5824-1-heiko@sntech.de>
 <20180515134736.5824-7-heiko@sntech.de>
Message-ID: <20180522171345.GA19614@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2018 at 03:47:36PM +0200, Heiko Stuebner wrote:
> The rk3328 uses a dw-hdmi controller with an external hdmi phy from
> Innosilicon which uses the generic phy framework for access.
> Add the necessary data and the compatible for the rk3328 to the
> rockchip dw-hdmi driver.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Tested-by: Robin Murphy <robin.murphy@arm.com>
> ---
> changes in v3:
> - reword as suggested by Rob to show that it's a dw-hdmi + Inno phy
> 
>  .../display/rockchip/dw_hdmi-rockchip.txt     |   1 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c   | 106 ++++++++++++++++++
>  2 files changed, 107 insertions(+)
