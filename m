From: robh@kernel.org (Rob Herring)
Date: Sat, 16 Dec 2017 12:09:36 -0600
Subject: [PATCH v2 01/19] dt-bindings: clock: Add ASPEED constants
In-Reply-To: <20171215062443.23059-2-joel@jms.id.au>
References: <20171215062443.23059-1-joel@jms.id.au>
 <20171215062443.23059-2-joel@jms.id.au>
Message-ID: <20171216180936.tpzd4zbbabp5s2oq@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 15, 2017 at 04:54:25PM +1030, Joel Stanley wrote:
> These will be merged as part of the clock driver. This commit is
> included so the tree will build without the clock series being applied.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  v2:
>   - remove NUM_CLKS define. There's no need for it to be part of ABI
> ---
>  include/dt-bindings/clock/aspeed-clock.h | 52 ++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 include/dt-bindings/clock/aspeed-clock.h

Reviewed-by: Rob Herring <robh@kernel.org>
