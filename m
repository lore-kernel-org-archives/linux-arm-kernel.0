From: robh@kernel.org (Rob Herring)
Date: Tue, 1 May 2018 11:27:18 -0500
Subject: [PATCH net-next v2 05/15] dt-bindings: net: dwmac-sun8i:
 simplify description of syscon property
In-Reply-To: <20180501161227.2110-6-wens@csie.org>
References: <20180501161227.2110-1-wens@csie.org>
 <20180501161227.2110-6-wens@csie.org>
Message-ID: <20180501162718.GA13139@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 02, 2018 at 12:12:17AM +0800, Chen-Yu Tsai wrote:
> The syscon property is used to point to the device that holds the glue
> layer control register known as the "EMAC (or GMAC) clock register".
> 
> We do not need to explicitly list what compatible strings are needed, as
> this information is readily available in the user manuals. Also the
> "syscon" device type is more of an implementation detail. There are many
> ways to access a register not in a device's address range, the syscon
> interface being the most generic and unrestricted one.
> 
> Simplify the description so that it says what it is supposed to
> describe.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/net/dwmac-sun8i.txt | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
