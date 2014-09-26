From: galak@codeaurora.org (Kumar Gala)
Date: Fri, 26 Sep 2014 11:01:37 -0500
Subject: [PATCH v2] ARM: DT: apq8064: add CM-QS600 board
In-Reply-To: <1411746990-12518-1-git-send-email-mike.rapoport@gmail.com>
References: <1411746990-12518-1-git-send-email-mike.rapoport@gmail.com>
Message-ID: <31A0A13F-5A20-41EB-B3F5-DB3CB13DEB48@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Sep 26, 2014, at 10:56 AM, Mike Rapoport <mike.rapoport@gmail.com> wrote:

Can you add some material here about the board.

> Signed-off-by: Mike Rapoport <mike.rapoport@gmail.com>
> ---
> v2 changes: duplicate the settings for the cm-qs600 board in its .dts file as Kumar suggested
> 

thanks

> arch/arm/boot/dts/Makefile                  |  1 +
> arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts | 59 +++++++++++++++++++++++++++++
> 2 files changed, 60 insertions(+)
> create mode 100644 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index aaa1a68..71d2ade 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -340,6 +340,7 @@ dtb-$(CONFIG_ARCH_ORION5X) += orion5x-lacie-d2-network.dtb \
> dtb-$(CONFIG_ARCH_PRIMA2) += prima2-evb.dtb
> dtb-$(CONFIG_ARCH_QCOM) += \
> 	qcom-apq8064-ifc6410.dtb \
> +	qcom-apq8064-cm-qs600.dtb \

sort alphabetically.

> 	qcom-apq8074-dragonboard.dtb \
> 	qcom-apq8084-ifc6540.dtb \
> 	qcom-apq8084-mtp.dtb \


- k
-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
