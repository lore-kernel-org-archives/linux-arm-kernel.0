From: robh@kernel.org (Rob Herring)
Date: Mon, 17 Sep 2018 01:45:09 -0400
Subject: [PATCH 1/2] dt-bindings: marvell,
 prestera: Add common compatible string
In-Reply-To: <20180907005926.27134-2-chris.packham@alliedtelesis.co.nz>
References: <20180907005926.27134-1-chris.packham@alliedtelesis.co.nz>
 <20180907005926.27134-2-chris.packham@alliedtelesis.co.nz>
Message-ID: <5b9f3f66.1c69fb81.e9b3c.3a62@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri,  7 Sep 2018 12:59:25 +1200, Chris Packham wrote:
> Add "marvell,prestera" as a compatible string so that drivers can be
> written to account for any prestera variant without needing to
> specialise to the more specific values.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  Documentation/devicetree/bindings/net/marvell,prestera.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
