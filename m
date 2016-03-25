From: robh@kernel.org (Rob Herring)
Date: Fri, 25 Mar 2016 09:41:20 -0500
Subject: [PATCH v3 04/18] dt-bindings: irq: arm,versatile-fpga: add
 compatible string for OX810SE SoC
In-Reply-To: <1458838215-23314-5-git-send-email-narmstrong@baylibre.com>
References: <1458838215-23314-1-git-send-email-narmstrong@baylibre.com>
 <1458838215-23314-5-git-send-email-narmstrong@baylibre.com>
Message-ID: <20160325144120.GA26839@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 24, 2016 at 05:50:01PM +0100, Neil Armstrong wrote:
> Under the OX810SE, this same controller is used as "Reference Peripheral
> Specification" Interrupt Controller, so add new compatible string to support
> the PLX Technology OX810SE SoC Interrupt Controller.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../devicetree/bindings/interrupt-controller/arm,versatile-fpga-irq.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
