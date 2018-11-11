From: robh@kernel.org (Rob Herring)
Date: Sun, 11 Nov 2018 16:35:39 -0600
Subject: [PATCH v6 5/9] dt-bindings: ARM: document marvell,ecc-enable
 binding
In-Reply-To: <20181109070349.20464-6-chris.packham@alliedtelesis.co.nz>
References: <20181109070349.20464-1-chris.packham@alliedtelesis.co.nz>
 <20181109070349.20464-6-chris.packham@alliedtelesis.co.nz>
Message-ID: <20181111223539.GA27390@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri,  9 Nov 2018 20:03:45 +1300, Chris Packham wrote:
> Add documentation for the marvell,ecc-enable and marvell,ecc-disable
> properties which can be used to enable/disable ECC on the Marvell aurora
> cache.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> Notes:
>     Changes in v6:
>     - new (split binding doc from implementation).
> 
>  Documentation/devicetree/bindings/arm/l2c2x0.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
