From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Wed, 18 Mar 2015 17:36:56 +0100
Subject: [STLinux Kernel] [PATCH 1/6] ARM: STi: DT: STiH407: Fix retime
 pin mask for PIO5 and PIO35
In-Reply-To: <1426675899-19882-2-git-send-email-lee.jones@linaro.org>
References: <1426675899-19882-1-git-send-email-lee.jones@linaro.org>
 <1426675899-19882-2-git-send-email-lee.jones@linaro.org>
Message-ID: <5509A9A8.5090206@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/18/2015 11:51 AM, Lee Jones wrote:
> From: Karim BEN BELGACEM <karim.ben-belgacem@st.com>
>
> This will avoid programming the retime registers when not implemented
>
> - PIO5  : no retime registers assigned to pins 6 and 7
> - PIO35 : pin 7 is reserved so no retime register assigned to it
>
> Signed-off-by: Karim BEN BELGACEM <karim.ben-belgacem@st.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>   arch/arm/boot/dts/stih407-pinctrl.dtsi | 2 ++
>   1 file changed, 2 insertions(+)
>

Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Thanks,
Maxime
