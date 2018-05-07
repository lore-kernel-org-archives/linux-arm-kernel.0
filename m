From: robh@kernel.org (Rob Herring)
Date: Mon, 7 May 2018 11:28:31 -0500
Subject: [PATCH v2 1/3] dt-bindings: iio: stm32-adc: add support for
 STM32MP1
In-Reply-To: <1525247091-18143-2-git-send-email-fabrice.gasnier@st.com>
References: <1525247091-18143-1-git-send-email-fabrice.gasnier@st.com>
 <1525247091-18143-2-git-send-email-fabrice.gasnier@st.com>
Message-ID: <20180507162830.GA11497@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 02, 2018 at 09:44:49AM +0200, Fabrice Gasnier wrote:
> Document support for STM32MP1 ADC. It's quite similar to STM32H7 ADC.
> Introduce "st,stm32mp1-adc" compatible to handle variants of this
> hardware such as vregready flag, interrupts, clock rate.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
> Changes in v2:
> - Update dt-bindings following Rob's remark: STM32MP1 ADC has two
>   interrupt lines
> ---
>  Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
