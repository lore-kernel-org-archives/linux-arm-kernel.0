From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Thu, 30 Apr 2015 13:22:11 +0200
Subject: [STLinux Kernel] [PATCH v2 1/6] ARM: STi: DT: STiH407: Fix retime
 pin mask for PIO5 and PIO35
In-Reply-To: <1426699279-9258-2-git-send-email-lee.jones@linaro.org>
References: <1426699279-9258-1-git-send-email-lee.jones@linaro.org>
 <1426699279-9258-2-git-send-email-lee.jones@linaro.org>
Message-ID: <55421063.6030206@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/18/2015 06:21 PM, Lee Jones wrote:
> From: Karim BEN BELGACEM <karim.ben-belgacem@st.com>
>
> This will avoid programming the retime registers when not implemented
>
> - PIO5  : no retime registers assigned to pins 6 and 7
> - PIO35 : pin 7 is reserved so no retime register assigned to it
>
> Signed-off-by: Karim BEN BELGACEM <karim.ben-belgacem@st.com>
> Acked-by: Maxime Coquelin <maxime.coquelin@st.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>   arch/arm/boot/dts/stih407-pinctrl.dtsi | 2 ++
>   1 file changed, 2 insertions(+)
>

Applied to sti_dt_for_v4.2.

Thanks!
Maxime
