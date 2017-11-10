From: robh@kernel.org (Rob Herring)
Date: Fri, 10 Nov 2017 15:21:39 -0600
Subject: [PATCH v4 3/4] dt-bindings: iio: adc: update the doc for SAR ADC
In-Reply-To: <20171107141020.30419-1-yixun.lan@amlogic.com>
References: <20171107141020.30419-1-yixun.lan@amlogic.com>
Message-ID: <20171110212139.ssh5kts3xo35hqeu@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 07, 2017 at 10:10:20PM +0800, Yixun Lan wrote:
> From: Xingyu Chen <xingyu.chen@amlogic.com>
> 
> Update the doc as the SAR ADC modules doesn't require "sana" clock.
> 
> Singed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt | 1 -
>  1 file changed, 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
