From: robh@kernel.org (Rob Herring)
Date: Thu, 29 Jun 2017 16:32:47 -0500
Subject: [PATCH v1 3/3] dt-bindings: Interconnect device-tree bindings
 draft
In-Reply-To: <20170627174903.27978-4-georgi.djakov@linaro.org>
References: <20170627174903.27978-1-georgi.djakov@linaro.org>
 <20170627174903.27978-4-georgi.djakov@linaro.org>
Message-ID: <20170629213247.qk54ocaomcz42gn7@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 27, 2017 at 08:49:03PM +0300, Georgi Djakov wrote:
> The interconnect API is not yet using DT bindings for expressing
> the relations between the API consumers and providers. This is
> posted a separate patch as it needs further discussions on how
> to represent this with DT.

I would recommend continuing to sort out how this works within the 
kernel before fixing things in DT. Something like this needs to be a 
core binding in the DT spec.

Also, you should CC some ARM, Ltd. folks like Mark R and Lorenzo. 
There's been some discussion in the past how to describe the DMA master 
side of the bus topology.

Rob
