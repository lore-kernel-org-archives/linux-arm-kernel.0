From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Tue, 9 Jun 2015 11:19:38 +0200
Subject: [PATCH 2/2] ARM: STi: DT: STiH407: Add cpu-release-addr dt
 property.
In-Reply-To: <1433780219-1245-3-git-send-email-peter.griffin@linaro.org>
References: <1433780219-1245-1-git-send-email-peter.griffin@linaro.org>
 <1433780219-1245-3-git-send-email-peter.griffin@linaro.org>
Message-ID: <5576AFAA.9090700@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/08/2015 06:16 PM, Peter Griffin wrote:
> To enable SMP when booting via u-boot we need to specify the
> newly implemented cpu-release-addr DT property.
>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>   arch/arm/boot/dts/stih407-family.dtsi | 4 ++++
>   1 file changed, 4 insertions(+)
>
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Thanks!
Maxime
