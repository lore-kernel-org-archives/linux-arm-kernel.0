From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 9 Jul 2014 20:22:28 +0530
Subject: [PATCH v3 0/5] phy: miphy365x: Introduce support for MiPHY365x
In-Reply-To: <1404906074-31992-1-git-send-email-lee.jones@linaro.org>
References: <1404906074-31992-1-git-send-email-lee.jones@linaro.org>
Message-ID: <53BD572C.4060406@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Wednesday 09 July 2014 05:11 PM, Lee Jones wrote:
> Hi Kishon,
> 
> This patchset is based on the two core patches you sent to the
> list which facilitate creating PHYs residing on multi-channel
> controllers.  The changes since the last submission centre
> around dynamic PHY creation based solely on what is provided via
> Device Tree, as requested.  The other review comments have also
> been addressed in this set.

This series looks good to me. Will queue it next week.

Thanks
Kishon
> 
> Kind regards,
> Lee
> 
>  .../devicetree/bindings/phy/phy-miphy365x.txt      |  76 +++
>  arch/arm/boot/dts/stih416-b2020-revE.dts           |  10 +
>  arch/arm/boot/dts/stih416-b2020.dts                |  12 +
>  arch/arm/boot/dts/stih416.dtsi                     |  22 +
>  drivers/phy/Kconfig                                |  10 +
>  drivers/phy/Makefile                               |   1 +
>  drivers/phy/phy-miphy365x.c                        | 636 +++++++++++++++++++++
>  include/dt-bindings/phy/phy-miphy365x.h            |  14 +
>  8 files changed, 781 insertions(+)
> 
