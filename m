From: robh@kernel.org (Rob Herring)
Date: Fri, 27 Apr 2018 16:08:15 -0500
Subject: [PATCH 18/27] dt-bindings: cp110: update documentation since DT
 de-duplication
In-Reply-To: <20180421151255.29929-19-miquel.raynal@bootlin.com>
References: <20180421151255.29929-1-miquel.raynal@bootlin.com>
 <20180421151255.29929-19-miquel.raynal@bootlin.com>
Message-ID: <20180427210815.nimaezoi66awszat@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 21, 2018 at 05:12:46PM +0200, Miquel Raynal wrote:
> CP110 master/slave DT files have been merged in a DT de-duplication work
> merged in v4.16. Update the syscon documentation accordingly to match
> the current state of the DT nodes.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../bindings/arm/marvell/cp110-system-controller.txt           | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
