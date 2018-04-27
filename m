From: robh@kernel.org (Rob Herring)
Date: Fri, 27 Apr 2018 15:47:23 -0500
Subject: [PATCH 13/17] dt-bindings/interrupt-controller: update Marvell
 ICU bindings
In-Reply-To: <20180421135537.24716-14-miquel.raynal@bootlin.com>
References: <20180421135537.24716-1-miquel.raynal@bootlin.com>
 <20180421135537.24716-14-miquel.raynal@bootlin.com>
Message-ID: <20180427204723.hz2ef5f7fhaid3aj@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 21, 2018 at 03:55:33PM +0200, Miquel Raynal wrote:
> Change the documentation to reflect the new bindings used for Marvell
> ICU. This involves describing each interrupt group as a subnode of the
> ICU node. Each of them having their own compatible.

Why?

This breaks compatibility.

> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../bindings/interrupt-controller/marvell,icu.txt  | 60 ++++++++++++++++------
>  1 file changed, 43 insertions(+), 17 deletions(-)
