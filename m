From: robh@kernel.org (Rob Herring)
Date: Wed, 7 Jun 2017 15:09:40 -0500
Subject: [PATCH v2 1/5] dt-bindings: iio: stm32-adc: add support for
 STM32H7
In-Reply-To: <1496050100-25854-2-git-send-email-fabrice.gasnier@st.com>
References: <1496050100-25854-1-git-send-email-fabrice.gasnier@st.com>
 <1496050100-25854-2-git-send-email-fabrice.gasnier@st.com>
Message-ID: <20170607200940.j6i2mtyc3nu4hwkj@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 29, 2017 at 11:28:16AM +0200, Fabrice Gasnier wrote:
> Document support for STM32H7 Analog to Digital Converter.
> Main difference is regarding compatible, clock definitions and new
> features like differential channels support:
> STM32H7 ADC block has two clock inputs, common clock for all ADCs.
> One 'bus' clock for registers access, and one optional 'adc' clock
> for analog circuitry (bus clock may be used for conversions).
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
> Changes in v2:
> - remarks from Rob: one compatible per line, s/unused/not present/
> - document resolutions available on stm32h7
> ---
>  .../devicetree/bindings/iio/adc/st,stm32-adc.txt   | 28 ++++++++++++++++------
>  1 file changed, 21 insertions(+), 7 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
