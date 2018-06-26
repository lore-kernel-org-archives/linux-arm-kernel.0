From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Tue, 26 Jun 2018 14:25:48 +0200
Subject: [PATCH] ARM: dts: stm32: Add DFSDM support to stm32mp157c
In-Reply-To: <1527067835-22303-1-git-send-email-fabrice.gasnier@st.com>
References: <1527067835-22303-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <8e696c04-2992-e20a-56ba-1b3097150ce9@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabrice,

On 05/23/2018 11:30 AM, Fabrice Gasnier wrote:
> stm32mp157c has DFSDM (Digital Filter For Sigma Delta Modulators) hardware
> with 6 filter instances.
> 
> Signed-off-by: Fabrice Gasnier<fabrice.gasnier@st.com>
> ---
>   arch/arm/boot/dts/stm32mp157c.dtsi | 70 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 70 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
> index 66d7496..3d2f4e7 100644
> --- a/arch/arm/boot/dts/stm32mp157c.dtsi
> +++ b/arch/arm/boot/dts/stm32mp157c.dtsi

Applied on stm32-next.

Thanks.
Alex
