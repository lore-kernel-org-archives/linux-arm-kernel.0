From: robh@kernel.org (Rob Herring)
Date: Mon, 16 Jul 2018 12:02:38 -0600
Subject: [PATCH v2 1/2] documentation: pinctrl: Add compatibles for
 Amlogic Meson G12A pin controllers
In-Reply-To: <20180714232754.5402-2-yixun.lan@amlogic.com>
References: <20180714232754.5402-1-yixun.lan@amlogic.com>
 <20180714232754.5402-2-yixun.lan@amlogic.com>
Message-ID: <20180716180238.GA19285@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 14, 2018 at 11:27:53PM +0000, Yixun Lan wrote:
> Add new compatible name for Amlogic's Meson-G12A pin controllers,
> add a dt-binding header file which document the detail pin names.
> 
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  .../bindings/pinctrl/meson,pinctrl.txt        |   2 +
>  include/dt-bindings/gpio/meson-g12a-gpio.h    | 114 ++++++++++++++++++
>  2 files changed, 116 insertions(+)
>  create mode 100644 include/dt-bindings/gpio/meson-g12a-gpio.h

Reviewed-by: Rob Herring <robh@kernel.org>
