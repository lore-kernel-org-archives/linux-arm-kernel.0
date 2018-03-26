From: robh@kernel.org (Rob Herring)
Date: Mon, 26 Mar 2018 17:23:08 -0500
Subject: [PATCH v2 3/4] dt-bindings: pwm: sunxi: add new compatible strings
In-Reply-To: <20180318232847.14278-4-andre.przywara@arm.com>
References: <20180318232847.14278-1-andre.przywara@arm.com>
 <20180318232847.14278-4-andre.przywara@arm.com>
Message-ID: <20180326222308.x25zptv7qwnwy4gi@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 18, 2018 at 11:28:46PM +0000, Andre Przywara wrote:
> The PWM controllers found in the Allwinner A64 and H5 SoCs are fully
> compatible to the PWM controllers found in the A13 and H3.
> Add new compatible strings for those SoCs to the binding document, so
> that they can be safely used, together with a fallback string
> (preferably "allwinner,sun5i-a13-pwm").
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-sun4i.txt | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
