From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 5 Jun 2014 16:09:47 +0100
Subject: [RESEND 0/4] phy: Introduce support for MiPHY365x
In-Reply-To: <1400766819-22286-1-git-send-email-lee.jones@linaro.org>
References: <1400766819-22286-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20140605150947.GG24240@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Hi Kishon,
> 
> As requested, please find the patches to be applied to your v3.16
> pull-request.

I guess this is not going to make v3.16 now. :(

Kishon can you make sure you queue for v3.17 ASAP please?

> Kind regards,
> Lee
> 
>  Documentation/devicetree/bindings/phy/phy-miphy365x.txt |  62 +++++++++++
>  arch/arm/boot/dts/stih416-b2020-revE.dts                |   6 +-
>  arch/arm/boot/dts/stih416-b2020.dts                     |   6 ++
>  arch/arm/boot/dts/stih416.dtsi                          |  14 +++
>  drivers/phy/Kconfig                                     |  10 ++
>  drivers/phy/Makefile                                    |   1 +
>  drivers/phy/phy-miphy365x.c                             | 630 ++++++++++++++++++++++
>  include/dt-bindings/phy/phy-miphy365x.h                 |  25 +++++
>  8 files changed, 753 insertions(+), 1 deletion(-)
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
