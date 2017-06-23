From: robh@kernel.org (Rob Herring)
Date: Fri, 23 Jun 2017 16:51:31 -0500
Subject: [PATCH v2 2/3] dt-bindings: input: Add DT bindings documentation
 for Allwinner A83T R_LRADC
In-Reply-To: <20170620134445.23097-3-techping.chan@gmail.com>
References: <20170620134445.23097-1-techping.chan@gmail.com>
 <20170620134445.23097-3-techping.chan@gmail.com>
Message-ID: <20170623215131.d5kickxtqdxxm3t4@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 20, 2017 at 09:44:44PM +0800, Ziping Chen wrote:
> From: Ziping Chen <techping.chan@gmail.com>

Your subject could be more concise. "DT bindings documentation" is 
redundant.

> 
> Allwinner A83T SoC has a low res adc like the one
> in Allwinner A10 SoC.
> 
> Add binding for it.
> 
> Signed-off-by: Ziping Chen <techping.chan@gmail.com>
> ---
>  Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Otherwise,

Acked-by: Rob Herring <robh@kernel.org>
