From: robh@kernel.org (Rob Herring)
Date: Mon, 12 Dec 2016 11:26:32 -0600
Subject: [PATCH 3/4] dt-bindings: power/supply: Update TPS65217 properties
In-Reply-To: <20161209062833.5768-4-woogyom.kim@gmail.com>
References: <20161209062833.5768-1-woogyom.kim@gmail.com>
 <20161209062833.5768-4-woogyom.kim@gmail.com>
Message-ID: <20161212172632.p6a3vvbs7bpm4uto@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 09, 2016 at 03:28:32PM +0900, Milo Kim wrote:
> Add interrupt specifiers for USB and AC charger input. Interrupt numbers
> are from the datasheet.
> Fix wrong property for compatible string.
> 
> Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
> ---
>  .../devicetree/bindings/power/supply/tps65217_charger.txt          | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
