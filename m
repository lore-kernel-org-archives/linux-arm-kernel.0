From: robh@kernel.org (Rob Herring)
Date: Tue, 3 Jul 2018 15:07:23 -0600
Subject: [PATCH v2 13/23] dt-bindings: ap806: prepare the syscon file to
 list other syscons nodes
In-Reply-To: <20180625151239.20976-14-miquel.raynal@bootlin.com>
References: <20180625151239.20976-1-miquel.raynal@bootlin.com>
 <20180625151239.20976-14-miquel.raynal@bootlin.com>
Message-ID: <20180703210722.GA329@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 25, 2018 at 05:12:29PM +0200, Miquel Raynal wrote:
> There are multiple system controllers in AP806. Because all syscon nodes
> use the same compatible, it is pertinent to use this same file to list
> IPs inside it. Thus, change the header to be more generic.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../bindings/arm/marvell/ap806-system-controller.txt           | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
