From: robh@kernel.org (Rob Herring)
Date: Mon, 10 Sep 2018 13:12:37 -0500
Subject: [PATCH v5 10/14] dt-bindings/interrupt-controller: update
 Marvell ICU bindings
In-Reply-To: <20180830073535.10710-11-miquel.raynal@bootlin.com>
References: <20180830073535.10710-1-miquel.raynal@bootlin.com>
 <20180830073535.10710-11-miquel.raynal@bootlin.com>
Message-ID: <20180910181237.GA4692@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 30 Aug 2018 09:35:31 +0200, Miquel Raynal wrote:
> Change the documentation to reflect the new bindings used for Marvell
> ICU. This involves describing each interrupt group as a subnode of the
> ICU node. Each of them having their own compatible.
> 
> The DT binding documentation still documents the legacy binding, where
> there was a single node with no subnode.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../interrupt-controller/marvell,icu.txt      | 85 ++++++++++++++++---
>  1 file changed, 73 insertions(+), 12 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
