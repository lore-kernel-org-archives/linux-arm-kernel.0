From: horms@verge.net.au (Simon Horman)
Date: Sat, 15 Dec 2012 18:05:28 +0900
Subject: [PATCH 1/7] ARM: sh7372: add missing "#interrupt-cells" properties
In-Reply-To: <1355503531-7276-2-git-send-email-g.liakhovetski@gmx.de>
References: <1355503531-7276-1-git-send-email-g.liakhovetski@gmx.de>
 <1355503531-7276-2-git-send-email-g.liakhovetski@gmx.de>
Message-ID: <20121215090527.GI9073@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 14, 2012 at 05:45:25PM +0100, Guennadi Liakhovetski wrote:
> Two of four interrupt controllers in sh7372.dtsi are missing the compulsory
> "#interrupt-cells" properties. Fix this.

Thanks.

I think that is fixed in the latest INTC DT series that I posted just
a few moments ago "[RFC v7 00/10] ARM: shmobile: DT initialisation of INTC
and GIC".

Sorry for sitting on that code for so long. Could you check if the
problem you saw is resolved?
