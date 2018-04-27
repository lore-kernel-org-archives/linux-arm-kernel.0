From: robh@kernel.org (Rob Herring)
Date: Fri, 27 Apr 2018 15:12:34 -0500
Subject: [PATCH v2 1/4] drm/panel: simple: Add support for Rocktech
 RK070ER9427 LCD panel
In-Reply-To: <20180427131040.28775-1-jagan@amarulasolutions.com>
References: <20180427131040.28775-1-jagan@amarulasolutions.com>
Message-ID: <20180427201234.hkaqkwa6zsj7tfda@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2018 at 06:40:40PM +0530, Jagan Teki wrote:
> This adds support for the Rocktech Display Ltd. RK070ER9427
> 800(RGB)x480 TFT LCD panel, which can be supported by the
> simple panel driver.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2:
> - included drm drm panel maintainers
> 
>  .../display/panel/rocktech,rk070er9427.txt         | 25 ++++++++++++++++
>  drivers/gpu/drm/panel/panel-simple.c               | 33 ++++++++++++++++++++++
>  2 files changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/rocktech,rk070er9427.txt

Reviewed-by: Rob Herring <robh@kernel.org>
