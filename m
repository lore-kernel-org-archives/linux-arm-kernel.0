From: robh@kernel.org (Rob Herring)
Date: Sun, 18 Mar 2018 07:48:23 -0500
Subject: [PATCH v3 3/6] dt-bindings: soc: Add a binding for the Broadcom
 VCHIQ services. (v3)
In-Reply-To: <20180309184417.23368-3-eric@anholt.net>
References: <20180309184417.23368-1-eric@anholt.net>
 <20180309184417.23368-3-eric@anholt.net>
Message-ID: <20180318124823.jfvoy3xraogsxpdi@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 09, 2018 at 10:44:14AM -0800, Eric Anholt wrote:
> The VCHIQ communication channel can be provided by BCM283x and Capri
> SoCs, to communicate with the VPU-side OS services.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
> 
> v2: VCHI->VCHIQ, dropped firmware property, added cache-line-size
> v3: Dropped cache-line-size, s/vchi@/mailbox@/
> 
>  .../devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt   | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt

Reviewed-by: Rob Herring <robh@kernel.org>
