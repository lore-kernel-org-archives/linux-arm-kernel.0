From: robh@kernel.org (Rob Herring)
Date: Mon, 10 Jul 2017 10:27:11 -0500
Subject: [PATCH v3 5/9] dt-bindings: iio: Add STM32 LPTimer trigger binding
In-Reply-To: <1499445068-7037-6-git-send-email-fabrice.gasnier@st.com>
References: <1499445068-7037-1-git-send-email-fabrice.gasnier@st.com>
 <1499445068-7037-6-git-send-email-fabrice.gasnier@st.com>
Message-ID: <20170710152711.wl6ujgy3lngtl42d@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 07, 2017 at 06:31:04PM +0200, Fabrice Gasnier wrote:
> Add documentation for STMicroelectronics STM32 Low-Power Timer Trigger
> binding.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
> Changes in v3:
> - Rob's comments: node name timer at ..., update reg property
>   description
> 
> Changes in v2:
> - s/Low Power/Low-Power
> - remove leading 0x in example (parent node)
> - improve reg property description
> ---
>  .../bindings/iio/timer/stm32-lptimer-trigger.txt   | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-lptimer-trigger.txt

Acked-by: Rob Herring <robh@kernel.org>
