From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 2 Jul 2014 14:49:57 +0530
Subject: [PATCH 0/5] phy: miphy365x: Introduce support for MiPHY365x
In-Reply-To: <1404133317-25953-1-git-send-email-lee.jones@linaro.org>
References: <1404133317-25953-1-git-send-email-lee.jones@linaro.org>
Message-ID: <53B3CEBD.2060609@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Monday 30 June 2014 06:31 PM, Lee Jones wrote:
> Hi Kishon,
> 
> This submission is the same as the last one, only each channel is
> now represented by its own sub-node.  The documentation has also

really cool.

Thanks
Kishon
> been updated accordingly.
> 
> Kind regards,
> Lee
> 
>  .../devicetree/bindings/phy/phy-miphy365x.txt      |  76 +++
>  arch/arm/boot/dts/stih416-b2020-revE.dts           |   5 +
>  arch/arm/boot/dts/stih416-b2020.dts                |   7 +
>  arch/arm/boot/dts/stih416.dtsi                     |  21 +
>  drivers/phy/Kconfig                                |  10 +
>  drivers/phy/Makefile                               |   1 +
>  drivers/phy/phy-miphy365x.c                        | 676 +++++++++++++++++++++
>  include/dt-bindings/phy/phy-miphy365x.h            |  25 +
>  8 files changed, 821 insertions(+)
> 
