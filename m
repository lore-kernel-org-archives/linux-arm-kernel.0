From: robh@kernel.org (Rob Herring)
Date: Fri, 23 Sep 2016 10:06:56 -0500
Subject: [PATCH 02/19] phy: stih41x-usb: Remove usb phy driver and dt
 binding documentation.
In-Reply-To: <1473859677-9231-3-git-send-email-peter.griffin@linaro.org>
References: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
 <1473859677-9231-3-git-send-email-peter.griffin@linaro.org>
Message-ID: <20160923150656.GB9176@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2016 at 02:27:40PM +0100, Peter Griffin wrote:
> This phy is only used on STiH415/6 based silicon, and support for
> these SoC's is being removed from the kernel.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Cc: <kishon@ti.com>
> ---
>  .../devicetree/bindings/phy/phy-stih41x-usb.txt    |  24 ---

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/phy/Kconfig                                |   8 -
>  drivers/phy/Makefile                               |   1 -
>  drivers/phy/phy-stih41x-usb.c                      | 188 ---------------------
>  4 files changed, 221 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/phy/phy-stih41x-usb.txt
>  delete mode 100644 drivers/phy/phy-stih41x-usb.c
