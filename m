From: robh@kernel.org (Rob Herring)
Date: Sun, 30 Oct 2016 15:41:26 -0500
Subject: [RFC PATCH 01/13] pinctrl: meson: Add GXL pinctrl definitions
In-Reply-To: <1477060838-14164-2-git-send-email-narmstrong@baylibre.com>
References: <1477060838-14164-1-git-send-email-narmstrong@baylibre.com>
 <1477060838-14164-2-git-send-email-narmstrong@baylibre.com>
Message-ID: <20161030204126.adj4bo7arpxxqtpf@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 21, 2016 at 04:40:26PM +0200, Neil Armstrong wrote:
> Add support for the Amlogic Meson GXL SoC, this is a partially complete
> definition only based on the Amlogic Vendor tree.
> 
> This definition differs a lot from the GXBB and needs a separate entry.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../devicetree/bindings/pinctrl/meson,pinctrl.txt  |   2 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/pinctrl/meson/Makefile                     |   3 +-
>  drivers/pinctrl/meson/pinctrl-meson-gxl.c          | 589 +++++++++++++++++++++
>  drivers/pinctrl/meson/pinctrl-meson.c              |   8 +
>  drivers/pinctrl/meson/pinctrl-meson.h              |   2 +
>  include/dt-bindings/gpio/meson-gxl-gpio.h          | 131 +++++
>  6 files changed, 734 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/pinctrl/meson/pinctrl-meson-gxl.c
>  create mode 100644 include/dt-bindings/gpio/meson-gxl-gpio.h
