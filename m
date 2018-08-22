From: horms@verge.net.au (Simon Horman)
Date: Wed, 22 Aug 2018 13:31:19 +0200
Subject: [PATCH /2] arm64: dts: renesas: r8a77970: add MMC support
In-Reply-To: <28c2a0ef-dc89-1fad-6502-9b33738b59a5@cogentembedded.com>
References: <1af46bf9-d9e5-8dcf-0ac7-a85e7348a34e@cogentembedded.com>
 <28c2a0ef-dc89-1fad-6502-9b33738b59a5@cogentembedded.com>
Message-ID: <20180822113119.4p2utcbx5ati74na@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 21, 2018 at 10:49:26PM +0300, Sergei Shtylyov wrote:
> Define the generic R8A77970 part of the MMC0 (SDHI2) device node.
> 
> Based on the original (and large) patches by Vladimir Barinov.
> 
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Thanks,

This looks fine to me but I will wait to see if there are other reviews
before applying.

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
