From: robh@kernel.org (Rob Herring)
Date: Fri, 27 Oct 2017 09:37:29 -0500
Subject: [PATCH v2 1/3] dt-bindings: iio: adc: stm32: add support for
 diff channels
In-Reply-To: <1508923665-2274-2-git-send-email-fabrice.gasnier@st.com>
References: <1508923665-2274-1-git-send-email-fabrice.gasnier@st.com>
 <1508923665-2274-2-git-send-email-fabrice.gasnier@st.com>
Message-ID: <20171027143729.7oqcps43qvieko4r@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 25, 2017 at 11:27:43AM +0200, Fabrice Gasnier wrote:
> STM32H7 ADC channels may be configured either as single-ended or
> differential.
> Add 'st,adc-diff-channels' property to support differential channels.
> Differential channels are defined as a pair of positive and negative
> inputs: vinp & vinn.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
> Changes in v2:
> - Add differential channels example
> - Add a note on mixed single-ended / differential channels
> ---
>  .../devicetree/bindings/iio/adc/st,stm32-adc.txt   | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
