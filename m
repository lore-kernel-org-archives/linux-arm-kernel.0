From: robh@kernel.org (Rob Herring)
Date: Wed, 26 Sep 2018 15:36:31 -0500
Subject: [PATCH 1/2] dt-bindings: crypto: hip07-sec, drop incorrect commas
In-Reply-To: <20180912160718.3324-2-Jonathan.Cameron@huawei.com>
References: <20180912160718.3324-2-Jonathan.Cameron@huawei.com>
Message-ID: <20180926203631.GA30812@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2018 at 05:07:17PM +0100, Jonathan Cameron wrote:
> There should not be a comma in the address used for the instance
> so drop them.
> 
> This is a left over from a review of the final version before
> Herbert Xu picked the series up.
> 
> Reported-by: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Fixes: 8f026dc887fe ("dt-bindings: Add bidnings for Hisilicon SEC crypto accelerators")
> ---
>  .../devicetree/bindings/crypto/hisilicon,hip07-sec.txt          | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. The dts change can go thru arm-soc.

Rob
