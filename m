From: robh@kernel.org (Rob Herring)
Date: Fri, 18 May 2018 11:35:41 -0500
Subject: [PATCH v5 3/9] dt-bindings: input: touchscreen: add minimum
 pressure touchscreen property
In-Reply-To: <1525949114-29263-4-git-send-email-eugen.hristev@microchip.com>
References: <1525949114-29263-1-git-send-email-eugen.hristev@microchip.com>
 <1525949114-29263-4-git-send-email-eugen.hristev@microchip.com>
Message-ID: <20180518163541.GA13676@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2018 at 01:45:08PM +0300, Eugen Hristev wrote:
> Add a common touchscreen optional property that will specify
> the minimum pressure applied to the screen that is needed
> such that the driver will report the touch event.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
> Changes in v5:
>  - Modified property name to touchscreen-min-pressure from
> touchscreen-threshold-property
> 
>  Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
