From: robh@kernel.org (Rob Herring)
Date: Fri, 16 Sep 2016 09:21:13 -0500
Subject: [PATCH v4 21/22] phy: Add support for Qualcomm's USB HSIC phy
In-Reply-To: <20160907213519.27340-22-stephen.boyd@linaro.org>
References: <20160907213519.27340-1-stephen.boyd@linaro.org>
 <20160907213519.27340-22-stephen.boyd@linaro.org>
Message-ID: <20160916142113.GA3973@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 07, 2016 at 02:35:18PM -0700, Stephen Boyd wrote:
> The HSIC USB controller on qcom SoCs has an integrated all
> digital phy controlled via the ULPI viewport.
> 
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---
>  .../devicetree/bindings/phy/qcom,usb-hsic-phy.txt  |  65 +++++++++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/phy/Kconfig                                |   7 +
>  drivers/phy/Makefile                               |   1 +
>  drivers/phy/phy-qcom-usb-hsic.c                    | 160 +++++++++++++++++++++
>  4 files changed, 233 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,usb-hsic-phy.txt
>  create mode 100644 drivers/phy/phy-qcom-usb-hsic.c
