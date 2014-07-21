From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Mon, 21 Jul 2014 11:33:42 +0200
Subject: [PATCH 5/6] ARM: STi: DT: STiH416: Supply Thermal Controller
 Device Tree nodes
In-Reply-To: <1401980819-19962-6-git-send-email-lee.jones@linaro.org>
References: <1401980819-19962-1-git-send-email-lee.jones@linaro.org>
 <1401980819-19962-6-git-send-email-lee.jones@linaro.org>
Message-ID: <53CCDE76.8060508@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On 06/05/2014 05:06 PM, Lee Jones wrote:
> We supply two of these.  The first is controlled by the System Configuration
> registers and the second one provided is a more traditional 'memory mapped'
> variant.  Each are handled by they own sub-driver.
>
> Signed-off-by: Ajit Pal Singh <ajitpal.singh@st.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>   arch/arm/boot/dts/stih416.dtsi | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
>

Added to my queue for v3.17.

Thanks,
Maxime
