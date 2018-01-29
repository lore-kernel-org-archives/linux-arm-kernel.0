From: horms@verge.net.au (Simon Horman)
Date: Mon, 29 Jan 2018 09:19:53 +0100
Subject: [PATCH 0/2] ARM: dts: r8a774[35]: sort subnodes of soc node
In-Reply-To: <20180126094052.17119-1-horms+renesas@verge.net.au>
References: <20180126094052.17119-1-horms+renesas@verge.net.au>
Message-ID: <20180129081953.u3olz55j4v464t5d@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 26, 2018 at 10:40:50AM +0100, Simon Horman wrote:
> Sort the subnodes of the soc node to improve maintainability.
> The sort key is the address on the bus with instances of the same
> IP block grouped together and sorted alphabetically.
> 
> Minor whitespace and line-wrapping changes are also made
> to match the formatting of R-Car Gen2 SoCs.
> 
> This is part of an ongoing effort to improve consistency within and between
> the DT of Renesas SoCs to allow for easier comparison and maintenance.
> 
> This patch should not introduce any functional change.
> 
> Based on renesas-devel-20180123-v4.15-rc9

I have applied this series with Geert's reviewed-by tags.
