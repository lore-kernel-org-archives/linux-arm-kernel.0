From: robh@kernel.org (Rob Herring)
Date: Fri, 27 Apr 2018 15:16:24 -0500
Subject: [PATCH 01/17] dt-bindings/interrupt-controller: fix Marvell ICU
 length in the example
In-Reply-To: <20180421135537.24716-2-miquel.raynal@bootlin.com>
References: <20180421135537.24716-1-miquel.raynal@bootlin.com>
 <20180421135537.24716-2-miquel.raynal@bootlin.com>
Message-ID: <20180427201624.piow2ubkyuajvcus@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 21, 2018 at 03:55:21PM +0200, Miquel Raynal wrote:
> ICU size in CP110 is not 0x10 but at least 0x440 bytes long (from the
> specification).
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  Documentation/devicetree/bindings/interrupt-controller/marvell,icu.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
