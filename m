From: horms@verge.net.au (Simon Horman)
Date: Mon, 4 Jun 2018 12:34:09 +0200
Subject: [PATCH 3/3] arm64: dts: renesas: v3hsk: specify GEther PHY IRQ
In-Reply-To: <9e6c40eb-71d0-d35b-1cf7-9179e093ed10@cogentembedded.com>
References: <4acc208e-c593-1e8a-00ca-fc9a5574074e@cogentembedded.com>
 <9e6c40eb-71d0-d35b-1cf7-9179e093ed10@cogentembedded.com>
Message-ID: <20180604103408.fonnt5qtzne3qfhn@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 01, 2018 at 11:47:14PM +0300, Sergei Shtylyov wrote:
> Specify GEther PHY IRQ in the V3H Starter Kit board's device tree, now
> that we have the GPIO support (previously phylib had to resort to polling).
> 
> Based on the original (and large) patch by Vladimir Barinov.
> 
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Given Olof Johansson's recent comments in ("Re: [GIT PULL] Renesas      
ARM64 Based SoC DT Updates for v4.18") please consider squashing this patch
and the previous one.

Other than that, this patch looks good to me.
