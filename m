From: robh@kernel.org (Rob Herring)
Date: Fri, 18 May 2018 09:20:33 -0500
Subject: [PATCH v5 4/9] dt-bindings: input: touchscreen:
 resistive-adc-touch: create bindings
In-Reply-To: <1525949114-29263-5-git-send-email-eugen.hristev@microchip.com>
References: <1525949114-29263-1-git-send-email-eugen.hristev@microchip.com>
 <1525949114-29263-5-git-send-email-eugen.hristev@microchip.com>
Message-ID: <20180518142033.GA28077@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2018 at 01:45:09PM +0300, Eugen Hristev wrote:
> Added bindings for generic resistive touchscreen ADC.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
> Changes in v5:
>  - changed property name touchscreen-threshold-pressure to
> touchscreen-min-pressure
> 
> Changes in v3:
>  - renamed file and compatible to exclude "generic" keyword
>  - removed the pressure threshold property, added it as a common
> touchscreen property in the touchscreen common bindings in a separate
> commit.
> 
> Changes in v2:
>  - modified bindings to have a generic resistive touchscreen adc driver
> instead of specific architecture one.
> 
> 
>  .../input/touchscreen/resistive-adc-touch.txt      | 30 ++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/resistive-adc-touch.txt

Reviewed-by: Rob Herring <robh@kernel.org>
