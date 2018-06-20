From: horms@verge.net.au (Simon Horman)
Date: Wed, 20 Jun 2018 10:49:11 +0200
Subject: [PATCH v2 1/2] arm64: dts: renesas: r8a77980: add PCIe support
In-Reply-To: <7e8c70ae-5c85-1e73-1be9-a40901a345f0@cogentembedded.com>
References: <b37d458c-071a-833a-2057-be8a07c880be@cogentembedded.com>
 <7e8c70ae-5c85-1e73-1be9-a40901a345f0@cogentembedded.com>
Message-ID: <20180620084910.fal6aym7b66zgqto@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2018 at 10:17:46PM +0300, Sergei Shtylyov wrote:
> Describe the PCIe PHY, PCIEC, and PCIe bus clock in the R8A77980 device
> tree.
> 
> Based on the original (and large) patch by Vladimir Barinov.
> 
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

This looks good to me.

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

I am marking it as deferred pending acceptance of the
renesas,r8a77980-pcie-phy binding. Please repost or otherwise
ping me once that has happened.
