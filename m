From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Wed, 22 Mar 2017 14:51:12 +0100
Subject: [PATCH v1 4/5] ARM: dts: stm32ap: Add watchdog support for
 STM32F429 eval board
In-Reply-To: <1490189786-19232-5-git-send-email-yannick.fertre@st.com>
References: <1490189786-19232-1-git-send-email-yannick.fertre@st.com>
 <1490189786-19232-5-git-send-email-yannick.fertre@st.com>
Message-ID: <877e3dbb-780c-1ece-04e1-594e8f783a5e@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 03/22/2017 02:36 PM, Yannick Fertre wrote:
> Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
> ---

Please add a commit message and change commit header as following:

ARM: dts: stm32: .....


>  arch/arm/boot/dts/stm32429i-eval.dts | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
> index 3c99466..aab81ed 100644
> --- a/arch/arm/boot/dts/stm32429i-eval.dts
> +++ b/arch/arm/boot/dts/stm32429i-eval.dts
> @@ -181,3 +181,7 @@
>  	pinctrl-names = "default";
>  	status = "okay";
>  };
> +
> +&iwdg {
> +	status = "okay";
> +};
>
