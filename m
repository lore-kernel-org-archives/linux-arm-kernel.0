From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 27 Mar 2018 10:29:17 -0700
Subject: [PATCH v5 10/13] ARM: dts: ipq4019: Add
 qcom-ipq4019-ap.dk07.1-c2 board file
In-Reply-To: <1521800336-19266-11-git-send-email-sricharan@codeaurora.org>
References: <1521800336-19266-1-git-send-email-sricharan@codeaurora.org>
 <1521800336-19266-11-git-send-email-sricharan@codeaurora.org>
Message-ID: <20180327172917.GM1403@tuxbook-pro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 23 Mar 03:18 PDT 2018, Sricharan R wrote:

> Reviewed-by: Abhishek Sahu <absahu@codeaurora.org>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  arch/arm/boot/dts/Makefile                      |  1 +
>  arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts | 26 +++++++++++++++++++++++++
>  2 files changed, 27 insertions(+)
>  create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index ae7f214..3b65e30 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -750,6 +750,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
>  	qcom-ipq4019-ap.dk04.1-c1.dtb \
>  	qcom-ipq4019-ap.dk04.1-c3.dtb \
>  	qcom-ipq4019-ap.dk07.1-c1.dtb \
> +	qcom-ipq4019-ap.dk07.1-c2.dtb \
>  	qcom-ipq8064-ap148.dtb \
>  	qcom-msm8660-surf.dtb \
>  	qcom-msm8960-cdp.dtb \
> diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts b/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts
> new file mode 100644
> index 0000000..c1e909c
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2018, The Linux Foundation. All rights reserved.
> +
> +#include "qcom-ipq4019-ap.dk07.1.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. IPQ4019/AP-DK07.1-C2";

compatible

Apart from that you have my

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
