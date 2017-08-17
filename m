From: robh@kernel.org (Rob Herring)
Date: Thu, 17 Aug 2017 17:18:55 -0500
Subject: [PATCH v2 2/2] dt-bindings: usb: keystone-usb: Update bindings
 pm and clocks properties
In-Reply-To: <20170816215408.13076-3-fcooper@ti.com>
References: <20170816215408.13076-1-fcooper@ti.com>
 <20170816215408.13076-3-fcooper@ti.com>
Message-ID: <20170817221855.7tcgsx4onukbooyu@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 16, 2017 at 04:54:08PM -0500, Franklin S Cooper Jr wrote:
> Update various properties to properly indicate their requirement depending
> on the SoC.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> ---
> Version 2:
> Clarify clock requirements in binding document
> 
>  Documentation/devicetree/bindings/usb/keystone-usb.txt | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
