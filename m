From: robh@kernel.org (Rob Herring)
Date: Thu, 6 Jul 2017 09:57:38 -0500
Subject: [PATCH 1/2] dt-bindings: pwm: add bindings doc for ZTE ZX PWM
 controller
In-Reply-To: <1498704874-14599-2-git-send-email-shawnguo@kernel.org>
References: <1498704874-14599-1-git-send-email-shawnguo@kernel.org>
 <1498704874-14599-2-git-send-email-shawnguo@kernel.org>
Message-ID: <20170706145738.5w3vk4cscvbki6vl@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 29, 2017 at 10:54:33AM +0800, Shawn Guo wrote:
> From: Shawn Guo <shawn.guo@linaro.org>
> 
> It adds bindings document for ZTE ZX PWM controller.  The device
> has two clocks: PCLK and WCLK.  The PCLK is for register access, and
> WCLK is the reference clock for calculating period and duty cycles.
> Also, the device supports polarity configuration, so #pwm-cells should
> be 3.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-zx.txt | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-zx.txt

Acked-by: Rob Herring <robh@kernel.org>
