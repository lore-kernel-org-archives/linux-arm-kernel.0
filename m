From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 10 Mar 2014 12:34:05 +0000
Subject: [PATCH v3 1/5] ARM: STi: Add STiH407 SoC support
In-Reply-To: <1394203251-25361-2-git-send-email-maxime.coquelin@st.com>
References: <1394203251-25361-1-git-send-email-maxime.coquelin@st.com>
 <1394203251-25361-2-git-send-email-maxime.coquelin@st.com>
Message-ID: <20140310123405.GU14976@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> This patch adds support to STiH407 SoC.
> 
> Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> ---
>  Documentation/arm/sti/stih407-overview.txt    | 18 ++++++++++++++++++
>  Documentation/devicetree/bindings/arm/sti.txt | 15 +++++++++++++++
>  arch/arm/mach-sti/Kconfig                     |  9 +++++++++
>  arch/arm/mach-sti/board-dt.c                  |  1 +
>  4 files changed, 43 insertions(+)
>  create mode 100644 Documentation/arm/sti/stih407-overview.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/sti.txt

<snip>

> +config SOC_STIH407
> +	bool "STiH407 STMicroelectronics Consumer Electronics family"
> +	default y
> +	help
> +	  This enables support for STMicroelectronics Digital Consumer
> +	  Electronics family StiH407 parts, primarily targeted at set-top-box
> +	  and other digital audio/video applications using Flattened Device
> +	  Trees.
> +

Are these configs actually used for something?

<snip>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
