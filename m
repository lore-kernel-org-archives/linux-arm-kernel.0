From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 10 Mar 2014 11:52:33 +0000
Subject: [PATCH 3/5] ARM: STi: DT: add keyscan for stih416
In-Reply-To: <1393990772-9567-4-git-send-email-gabriel.fernandez@st.com>
References: <1393990772-9567-1-git-send-email-gabriel.fernandez@st.com>
 <1393990772-9567-4-git-send-email-gabriel.fernandez@st.com>
Message-ID: <20140310115233.GQ14976@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Add keyscan support for stih416.
> It is disabled by default given that it is not enabled on all boards.
> Also there are PIOs conflict with already claimed lines.
> 
> Signed-off-by: Giuseppe Condorelli <giuseppe.condorelli@st.com>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---
>  arch/arm/boot/dts/stih416-pinctrl.dtsi | 16 ++++++++++++++++
>  arch/arm/boot/dts/stih416.dtsi         | 10 ++++++++++
>  2 files changed, 26 insertions(+)

Looks good:
  Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
