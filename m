From: horms@verge.net.au (Simon Horman)
Date: Wed, 22 Aug 2018 13:31:00 +0200
Subject: [PATCH 2/2] arm64: dts: renesas: v3msk: add eMMC support
In-Reply-To: <9da672a2-0269-4860-8912-189414b43d4c@cogentembedded.com>
References: <1af46bf9-d9e5-8dcf-0ac7-a85e7348a34e@cogentembedded.com>
 <9da672a2-0269-4860-8912-189414b43d4c@cogentembedded.com>
Message-ID: <20180822113100.edpyplj2kteomr2j@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 21, 2018 at 10:50:31PM +0300, Sergei Shtylyov wrote:
> Add the eMMC chip support for the V3M Started Kit board.
> 
> Based on the original (and large) patches by Vladimir Barinov.
> 
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Thanks,

This looks fine to me but I will wait to see if there are other reviews
before applying.

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

I am, however, curious to know about HS200.
Is it supported on the v3msk? If so, do you have any plans to enable it?
