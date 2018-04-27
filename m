From: robh@kernel.org (Rob Herring)
Date: Fri, 27 Apr 2018 15:51:33 -0500
Subject: [PATCH 14/27] dt-bindings: cp110: rename cp110 syscon file
In-Reply-To: <20180421151255.29929-15-miquel.raynal@bootlin.com>
References: <20180421151255.29929-1-miquel.raynal@bootlin.com>
 <20180421151255.29929-15-miquel.raynal@bootlin.com>
Message-ID: <20180427205133.vwbvnwdhjhik5f54@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 21, 2018 at 05:12:42PM +0200, Miquel Raynal wrote:
> There is no need to give numbers to system controllers inside the
> documentation as the syscons use the same compatibles. Furthermore, this
> approach does not scale very well and would force the creation of a new
> file each time a new syscon is added in the device tree.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../marvell/{cp110-system-controller0.txt => cp110-system-controller.txt} | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename Documentation/devicetree/bindings/arm/marvell/{cp110-system-controller0.txt => cp110-system-controller.txt} (100%)

Reviewed-by: Rob Herring <robh@kernel.org>
