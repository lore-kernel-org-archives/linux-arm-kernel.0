From: robh@kernel.org (Rob Herring)
Date: Fri, 23 Sep 2016 10:06:36 -0500
Subject: [PATCH 01/19] phy: phy-miphy365x: Remove miphy365 driver and dt
 binding documentation.
In-Reply-To: <1473859677-9231-2-git-send-email-peter.griffin@linaro.org>
References: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
 <1473859677-9231-2-git-send-email-peter.griffin@linaro.org>
Message-ID: <20160923150636.GA9176@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2016 at 02:27:39PM +0100, Peter Griffin wrote:
> This phy is only used on STiH415/6 based silicon, and support for
> these SoC's is being removed from the kernel.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Cc: <kishon@ti.com>
> ---
>  .../devicetree/bindings/phy/phy-miphy365x.txt      |  77 ---

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/phy/Kconfig                                |  10 -
>  drivers/phy/Makefile                               |   1 -
>  drivers/phy/phy-miphy365x.c                        | 625 ---------------------
>  4 files changed, 713 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/phy/phy-miphy365x.txt
>  delete mode 100644 drivers/phy/phy-miphy365x.c
