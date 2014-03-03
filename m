From: galak@codeaurora.org (Kumar Gala)
Date: Mon, 3 Mar 2014 10:07:24 -0600
Subject: [PATCH v2 1/1] arm64: Add initial dts for Cavium Thunder SoC
In-Reply-To: <1393831142-27952-2-git-send-email-mohun106@gmail.com>
References: <1393831142-27952-1-git-send-email-mohun106@gmail.com>
 <1393831142-27952-2-git-send-email-mohun106@gmail.com>
Message-ID: <D69CC7F2-C9AC-45CE-AFD1-56CE4441F822@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Mar 3, 2014, at 1:19 AM, mohun106 at gmail.com wrote:

> From: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
> 
> Signed-off-by: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
> ---
> arch/arm64/boot/dts/Makefile    |    1 +
> arch/arm64/boot/dts/thunder.dts |  158 +++++++++++++++++++++++++++++++++++++++
> 2 files changed, 159 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
> index c52bdb0..d339343 100644
> --- a/arch/arm64/boot/dts/Makefile
> +++ b/arch/arm64/boot/dts/Makefile
> @@ -1,5 +1,6 @@
> dtb-$(CONFIG_ARCH_VEXPRESS) += rtsm_ve-aemv8a.dtb foundation-v8.dtb
> dtb-$(CONFIG_ARCH_XGENE) += apm-mustang.dtb
> +dtb-$(CONFIG_ARCH_THUNDER) += thunder.dtb

Where is the Kconfig associated with CONFIG_ARCH_THUNDER?  Also, I know on arch/arm we are moving to CONFIG_SOC_ instead of CONFIG_ARCH_, I assume the same is true for arm64.

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
