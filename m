From: robh@kernel.org (Rob Herring)
Date: Tue, 18 Oct 2016 11:47:05 -0500
Subject: [PATCH v5 23/23] phy: Add support for Qualcomm's USB HS phy
In-Reply-To: <20161018015636.11701-24-stephen.boyd@linaro.org>
References: <20161018015636.11701-1-stephen.boyd@linaro.org>
 <20161018015636.11701-24-stephen.boyd@linaro.org>
Message-ID: <20161018164705.viqrzpn3bnwns2mc@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2016 at 06:56:36PM -0700, Stephen Boyd wrote:
> The high-speed phy on qcom SoCs is controlled via the ULPI
> viewport.
> 
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: <devicetree@vger.kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---
>  .../devicetree/bindings/phy/qcom,usb-hs-phy.txt    |  86 +++++++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/phy/Kconfig                                |   8 +
>  drivers/phy/Makefile                               |   1 +
>  drivers/phy/phy-qcom-usb-hs.c                      | 286 +++++++++++++++++++++
>  4 files changed, 381 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.txt
>  create mode 100644 drivers/phy/phy-qcom-usb-hs.c
