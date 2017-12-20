From: robh@kernel.org (Rob Herring)
Date: Wed, 20 Dec 2017 15:08:01 -0600
Subject: [PATCH v5 01/11] dt-bindings: thermal: Describe Armada AP806 and
 CP110
In-Reply-To: <20171219135719.9531-2-miquel.raynal@free-electrons.com>
References: <20171219135719.9531-1-miquel.raynal@free-electrons.com>
 <20171219135719.9531-2-miquel.raynal@free-electrons.com>
Message-ID: <20171220210801.z3mwkpmxymhakb4c@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 19, 2017 at 02:57:09PM +0100, Miquel Raynal wrote:
> From: Baruch Siach <baruch@tkos.co.il>
> 
> Add compatible strings for AP806 and CP110 that are part of the Armada
> 8k/7k line of SoCs.
> 
> Add a note on the differences in the size of the control area in
> different bindings. This is an existing difference between the Armada
> 375 binding and the other boards already supported. The new AP806 and
> CP110 bindings are similar to the existing Armada 375 in this regard.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> [<miquel.raynal@free-electrons.com>: reword, additional details]
> Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
> ---
>  .../devicetree/bindings/thermal/armada-thermal.txt | 37 +++++++++++++++-------
>  1 file changed, 25 insertions(+), 12 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
