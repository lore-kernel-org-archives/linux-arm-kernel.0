From: pombredanne@nexb.com (Philippe Ombredanne)
Date: Mon, 12 Feb 2018 10:39:29 +0100
Subject: [PATCH v3 2/3] arm64: dts: sdm845: Add minimal dts files for
 sdm845 SoC/MTP
In-Reply-To: <20180212062832.2791-3-rnayak@codeaurora.org>
References: <20180212062832.2791-1-rnayak@codeaurora.org>
 <20180212062832.2791-3-rnayak@codeaurora.org>
Message-ID: <CAOFm3uH7gVG_h-uh+ZgN3_YzHQMBGV+2neUEcyETdppouZF4Sg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 12, 2018 at 7:28 AM, Rajendra Nayak <rnayak@codeaurora.org> wrote:
> Add a skeletal sdm845 SoC dtsi and MTP board dts/dtsi files
>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/Makefile       |   1 +
>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts |  13 ++
>  arch/arm64/boot/dts/qcom/sdm845.dtsi    | 275 ++++++++++++++++++++++++++++++++
>  3 files changed, 289 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sdm845-mtp.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sdm845.dtsi
>
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 55ec5ee7f7e8..9319e74b8906 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -6,3 +6,4 @@ dtb-$(CONFIG_ARCH_QCOM) += msm8916-mtp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += msm8992-bullhead-rev-101.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += msm8994-angler-rev-101.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += msm8996-mtp.dtb
> +dtb-$(CONFIG_ARCH_QCOM)        += sdm845-mtp.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> new file mode 100644
> index 000000000000..617c7bb25fb1
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + */

This is more cosmetic, but since there is only a single line of
copyright statement and no other comments, it would make sense to use
C++ style // for that line too IMHO (and other similar cases)
-- 
Cordially
Philippe Ombredanne
