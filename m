From: dwalker@codeaurora.org (Daniel Walker)
Date: Mon, 24 Jan 2011 12:46:16 -0800
Subject: [PATCH v2 07/11] msm: Add MSM 8960 cpu_is check
In-Reply-To: <1295468747-22796-8-git-send-email-davidb@codeaurora.org>
References: <1292384961-8851-1-git-send-email-stepanm@codeaurora.org>
	<1295468747-22796-1-git-send-email-davidb@codeaurora.org>
	<1295468747-22796-8-git-send-email-davidb@codeaurora.org>
Message-ID: <1295901976.29639.53.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-01-19 at 12:25 -0800, David Brown wrote:
> diff --git a/arch/arm/mach-msm/include/mach/cpu.h
> b/arch/arm/mach-msm/include/mach/cpu.h
> index e1ba9db..a9481b0 100644
> --- a/arch/arm/mach-msm/include/mach/cpu.h
> +++ b/arch/arm/mach-msm/include/mach/cpu.h
> @@ -24,6 +24,7 @@
>  #define cpu_is_msm7x30()       0
>  #define cpu_is_qsd8x50()       0
>  #define cpu_is_msm8x60()       0
> +#define cpu_is_msm8960()       0

The naming is just perverted even more here..

Daniel

-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
