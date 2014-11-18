From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Tue, 18 Nov 2014 12:51:31 +0100
Subject: [PATCH v5 4/8] ARM: DT: STi: STiH407: Add DT node for MiPHY28lp
In-Reply-To: <1415098284-11182-5-git-send-email-gabriel.fernandez@linaro.org>
References: <1415098284-11182-1-git-send-email-gabriel.fernandez@linaro.org>
 <1415098284-11182-5-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <546B32C3.8000602@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gabriel,
On 11/04/2014 11:51 AM, Gabriel FERNANDEZ wrote:
> The MiPHY28lp is a Generic PHY which can serve various SATA, PCIe or
> USB3 devices. The two first ports can be use for either; both SATA, both
> PCIe or one of each in any configuration.
> The Third port is only for USB3.
>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
> ---
>   arch/arm/boot/dts/stih407-b2120.dts | 11 +++++++
>   arch/arm/boot/dts/stih407.dtsi      | 65 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 76 insertions(+)

Finally, I won't apply this  patch in its current form.

Indeed, you should follow Arnd recommendations on Syscfg registers 
handling in DT.
See https://lkml.org/lkml/2014/11/13/161

Regards,
Maxime
