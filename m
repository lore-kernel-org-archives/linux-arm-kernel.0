From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Wed, 22 Jul 2015 11:42:08 +0200
Subject: [PATCH 9/9] ARM: STi: DT: Rename st_pll3200c32_407_c0_x into
 st_pll3200c32_cx_x
In-Reply-To: <1435068567-30995-10-git-send-email-gabriel.fernandez@linaro.org>
References: <1435068567-30995-1-git-send-email-gabriel.fernandez@linaro.org>
 <1435068567-30995-10-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <55AF6570.3010505@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gabriel,

On 06/23/2015 04:09 PM, Gabriel Fernandez wrote:
> Use a generic name for this kind of PLL
>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
> ---
>   Documentation/devicetree/bindings/clock/st/st,clkgen-pll.txt | 4 ++--
>   arch/arm/boot/dts/stih407-clock.dtsi                         | 4 ++--
>   arch/arm/boot/dts/stih410-clock.dtsi                         | 4 ++--
>   arch/arm/boot/dts/stih418-clock.dtsi                         | 4 ++--
>   4 files changed, 8 insertions(+), 8 deletions(-)
>
>

Patch applied to sti-dt-for-v4.3.

Thanks!
Maxime
