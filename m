From: robh@kernel.org (Rob Herring)
Date: Mon, 16 May 2016 11:45:38 -0500
Subject: [PATCH v10 6/8] dt-bindings: i2c: rk3x: add support for rk3399
In-Reply-To: <1463407452-41418-1-git-send-email-david.wu@rock-chips.com>
References: <1463407063-41218-1-git-send-email-david.wu@rock-chips.com>
 <1463407452-41418-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <20160516164538.GA27178@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 16, 2016 at 10:04:12PM +0800, David Wu wrote:
> The bus clock and function clock are separated at rk3399,
> and others use one clock as the bus clock and function clock.
> 
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> ---
> Change in v10:
> - none
> 
> Change in v9:
> - remove unnecessary "REQUIRED".
> 
> Change in v8:
> - remove error description.
> 
>  Documentation/devicetree/bindings/i2c/i2c-rk3x.txt | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
