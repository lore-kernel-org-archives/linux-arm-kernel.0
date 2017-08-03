From: robh@kernel.org (Rob Herring)
Date: Thu, 3 Aug 2017 12:01:54 -0500
Subject: [PATCH v2 2/3] dt-bindings: iio: adc: stm32: add optional
 st,min-sample-time-nsecs
In-Reply-To: <1500912640-23927-3-git-send-email-fabrice.gasnier@st.com>
References: <1500912640-23927-1-git-send-email-fabrice.gasnier@st.com>
 <1500912640-23927-3-git-send-email-fabrice.gasnier@st.com>
Message-ID: <20170803170154.bizlx2dvdbwtgmoy@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 24, 2017 at 06:10:39PM +0200, Fabrice Gasnier wrote:
> STM32 ADC allows each channel to be sampled with a different sampling
> time. There's an application note that deals with this: 'How to get
> the best ADC accuracy in STM32...' It basically depends on analog input
> signal electrical properties (depends on board).
> 
> Add optional 'st,min-sample-time-nsecs' property so this can be tuned
> in dt.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
> Changes in v2:
> - Use 'st,min-sample-time-nsecs' instead of 'min-sample-time'.
> ---
>  Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt | 5 +++++
>  1 file changed, 5 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
