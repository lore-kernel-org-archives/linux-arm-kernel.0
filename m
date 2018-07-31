From: horms@verge.net.au (Simon Horman)
Date: Tue, 31 Jul 2018 12:24:45 +0200
Subject: [PATCH] arm64: dts: renesas: r8a77980: move IPMMU nodes
In-Reply-To: <5f7daa87-b0b3-faa7-0331-640c39961b4a@cogentembedded.com>
References: <2368353.xfo5beGC5E@wasted.cogentembedded.com>
 <5f7daa87-b0b3-faa7-0331-640c39961b4a@cogentembedded.com>
Message-ID: <20180731102444.w4tlzk26mnr37wak@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2018 at 09:51:18PM +0300, Sergei Shtylyov wrote:
> The IPMMU nodes should follow the GEther node, not the CAN-FD node,
> according to the <unit-address> part of the startng IPMMU-DS1 node.
> While moving the nodes, also do sort them by label alphanumerically...
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Thanks Sergei, applied for v4.20.
