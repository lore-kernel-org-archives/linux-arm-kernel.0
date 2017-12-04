From: robh@kernel.org (Rob Herring)
Date: Mon, 4 Dec 2017 16:33:22 -0600
Subject: [PATCH v2 1/4] dt-bindings: thermal/armada: describe AP806 and
 CP110
In-Reply-To: <f8c589337a4fb78852eadf15058e8f8d132d4dc0.1512299484.git.baruch@tkos.co.il>
References: <f8c589337a4fb78852eadf15058e8f8d132d4dc0.1512299484.git.baruch@tkos.co.il>
Message-ID: <20171204223322.sfm7ryrqmlaslmq3@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 03, 2017 at 01:11:21PM +0200, Baruch Siach wrote:
> Add compatible strings for AP806 and CP110 that are part of the Armada 8k/7k
> line of SoCs.
> 
> Add a note on the difference in the size of the control area in different
> bindings. This is an existing difference between the Armada 375 binding and
> the rest. The new AP806 and CP110 bindings are similar to the existing Armada
> 375 in this regard.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> v2: No change
> ---
>  Documentation/devicetree/bindings/thermal/armada-thermal.txt | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
