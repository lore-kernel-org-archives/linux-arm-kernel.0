From: robh@kernel.org (Rob Herring)
Date: Sat, 21 Jan 2017 14:54:40 -0600
Subject: [PATCH 4/7] Documentation: dt: iio: stm32-adc: optional dma
 support
In-Reply-To: <1484832854-6314-5-git-send-email-fabrice.gasnier@st.com>
References: <1484832854-6314-1-git-send-email-fabrice.gasnier@st.com>
 <1484832854-6314-5-git-send-email-fabrice.gasnier@st.com>
Message-ID: <20170121205440.s32egtpu5tmlbkdi@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2017 at 02:34:11PM +0100, Fabrice Gasnier wrote:
> STM32 ADC can use dma. Add dt documentation for optional dma support.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt | 7 +++++++
>  1 file changed, 7 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
