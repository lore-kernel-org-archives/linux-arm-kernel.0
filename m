From: robh@kernel.org (Rob Herring)
Date: Wed, 1 Feb 2017 07:27:18 -0600
Subject: [PATCH 2/5] DT: mfd: axp20x: Add binding for the AXP808
In-Reply-To: <abb27901379a19a11608fd37254e1a8f7fa1b199.1485456006.git.rask@formelder.dk>
References: <cover.1485456003.git.rask@formelder.dk>
 <abb27901379a19a11608fd37254e1a8f7fa1b199.1485456006.git.rask@formelder.dk>
Message-ID: <20170201132717.zaskc3bmmsutntbl@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2017 at 10:16:13PM +0100, Rask Ingemann Lambertsen wrote:
> The AXP808 does not support address space extension, but is otherwise
> identical to the AXP806, including the chip ID, so add a compatible
> string for it to the binding.
> 
> Signed-off-by: Rask Ingemann Lambertsen <rask@formelder.dk>
> ---
>  Documentation/devicetree/bindings/mfd/axp20x.txt | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
