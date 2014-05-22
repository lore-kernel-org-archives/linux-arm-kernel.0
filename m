From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Thu, 22 May 2014 17:50:49 +0200
Subject: [PATCH 3/8] ARM: STi: DT: Add sdhci pins for stih416
In-Reply-To: <1400771902-26553-4-git-send-email-peter.griffin@linaro.org>
References: <1400771902-26553-1-git-send-email-peter.griffin@linaro.org>
 <1400771902-26553-4-git-send-email-peter.griffin@linaro.org>
Message-ID: <537E1CD9.5020900@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/22/2014 05:18 PM, Peter Griffin wrote:
> This adds the required pin config for both SDHCI controllers on
> the stih416 SoC.
>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> ---
>   arch/arm/boot/dts/stih416-pinctrl.dtsi | 39 ++++++++++++++++++++++++++++++++++
>   1 file changed, 39 insertions(+)
>


For all the DT patches, once Lee's comments taken into account, you can 
add my:

Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Thanks!
Maxime
