From: robh@kernel.org (Rob Herring)
Date: Tue, 14 Aug 2018 14:46:45 -0600
Subject: [PATCH 1/3] dt-bindings: iio: vadc: Fix documentation of 'reg'
In-Reply-To: <20180808191339.16875-2-mka@chromium.org>
References: <20180808191339.16875-1-mka@chromium.org>
 <20180808191339.16875-2-mka@chromium.org>
Message-ID: <20180814204645.GA8696@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed,  8 Aug 2018 12:13:37 -0700, Matthias Kaehlcke wrote:
> The documentation of Qualcomm's SPMI PMIC voltage ADC claims that the
> 'reg' property consists of two values, the SPMI address and the length
> of the controller's registers. However the SPMI bus to which it is added
> specifies "#size-cells = <0>;". Remove the controller register length
> from the documentation of the field and the example.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
