From: robh@kernel.org (Rob Herring)
Date: Wed, 24 Oct 2018 08:56:33 -0500
Subject: [PATCH v5 04/11] dt-bindings: iio: adc: add AXP803 ADC bindings
In-Reply-To: <20181023185330.10472-5-oskari@lemmela.net>
References: <20181023185330.10472-1-oskari@lemmela.net>
 <20181023185330.10472-5-oskari@lemmela.net>
Message-ID: <20181024135633.GA342@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Oct 2018 21:53:23 +0300, Oskari Lemmela wrote:
> The AXP803 ADC is compatible with AXP813 ADC, but add
> specific compatible for it.
> 
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> ---
>  Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
