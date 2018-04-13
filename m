From: robh@kernel.org (Rob Herring)
Date: Fri, 13 Apr 2018 13:33:07 -0500
Subject: [PATCH v3 04/11] dt-bindings: input: touchscreen: add pressure
 threshold touchscreen property
In-Reply-To: <1523350677-27106-5-git-send-email-eugen.hristev@microchip.com>
References: <1523350677-27106-1-git-send-email-eugen.hristev@microchip.com>
 <1523350677-27106-5-git-send-email-eugen.hristev@microchip.com>
Message-ID: <20180413183307.vqadfoxvwyzyrjti@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 10, 2018 at 11:57:50AM +0300, Eugen Hristev wrote:
> Add a common touchscreen optional property that will specify
> the minimum pressure applied to the screen that is needed
> such that the driver will report the touch event.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
