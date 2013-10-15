From: cov@codeaurora.org (Christopher Covington)
Date: Tue, 15 Oct 2013 14:09:19 -0400
Subject: [RFC PATCH 1/4] ARM64: Add Kconfig option to enable Big Endian
 kernel
In-Reply-To: <1381494135-15085-2-git-send-email-ankit.jindal@linaro.org>
References: <1381494135-15085-1-git-send-email-ankit.jindal@linaro.org>
 <1381494135-15085-2-git-send-email-ankit.jindal@linaro.org>
Message-ID: <525D84CF.4060705@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ankit,

On 10/11/2013 08:22 AM, Ankit Jindal wrote:
> This patch adds Kconfig options and relevant Big Endian compiler flags.
[...]
> diff --git a/arch/arm64/mm/Kconfig b/arch/arm64/mm/Kconfig
> new file mode 100644
> index 0000000..e4122ac
> --- /dev/null
> +++ b/arch/arm64/mm/Kconfig
> @@ -0,0 +1,7 @@
> +config CPU_BIG_ENDIAN
> +        bool "Build big-endian kernel"
> +        help
> +          Say Y if you plan on running a kernel in big-endian mode.
> +          Note that your board must be properly built [...]

What makes a board properly built and how can a user determine whether their
board is?

> +                                                [...] and your board
> +          port must properly enable any big-endian related features
> +          of your chipset/board/processor.

What is a board port for arm64?

Thanks,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
