From: robh@kernel.org (Rob Herring)
Date: Tue, 3 Jul 2018 15:07:35 -0600
Subject: [PATCH v2 14/23] dt-bindings: cp110: prepare the syscon file to
 list other syscons nodes
In-Reply-To: <20180625151239.20976-15-miquel.raynal@bootlin.com>
References: <20180625151239.20976-1-miquel.raynal@bootlin.com>
 <20180625151239.20976-15-miquel.raynal@bootlin.com>
Message-ID: <20180703210735.GB329@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 25, 2018 at 05:12:30PM +0200, Miquel Raynal wrote:
> There are multiple system controllers in CP110. Because all syscon nodes
> use the same compatible, it is pertinent to use this same file to list
> IPs inside it. Thus, change the header to be more generic, and align
> with AP806 file.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../bindings/arm/marvell/cp110-system-controller.txt       | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
