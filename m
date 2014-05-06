From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 6 May 2014 08:18:43 +0100
Subject: [PATCH 1/9] ARM: STi: DT: STiH416: 416 DT Entry for clockgen
 A0/1/10/11/12
In-Reply-To: <1399305223-18703-2-git-send-email-gabriel.fernandez@linaro.org>
References: <1399305223-18703-1-git-send-email-gabriel.fernandez@linaro.org>
 <1399305223-18703-2-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <20140506071843.GD5206@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Patch adds DT entries for clockgen A0/1/10/11/12
> 
> Signed-off-by: Pankaj Dev <pankaj.dev@st.com>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
> ---
>  arch/arm/boot/dts/stih416-clks.h     |  15 ++

This should live in include/dt-bindings/clk

>  arch/arm/boot/dts/stih416-clock.dtsi | 477 ++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/stih416.dtsi       |  10 +-
>  3 files changed, 497 insertions(+), 5 deletions(-)
>  create mode 100644 arch/arm/boot/dts/stih416-clks.h

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
