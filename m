From: horms@verge.net.au (Simon Horman)
Date: Sun, 13 May 2018 10:07:04 +0200
Subject: [PATCH 2/2] arm64: dts: renesas: initial V3HSK board device tree
In-Reply-To: <50de037c-7560-c261-f96a-f86065674c9b@cogentembedded.com>
References: <3923fc5f-103c-94c9-57ba-cb29e8c55d05@cogentembedded.com>
 <50de037c-7560-c261-f96a-f86065674c9b@cogentembedded.com>
Message-ID: <20180513080704.yeypjjtv7hdmqajt@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2018 at 09:12:30PM +0300, Sergei Shtylyov wrote:
> Add the initial device  tree for  the V3H Starter Kit board.
> The board has 1 debug serial port (SCIF0); include support for it,
> so that the serial console can work.
> 
> Based on the original (and large) patch by Vladimir Barinov.
> 
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

This looks fine but I will wait to see if there are other reviews before
applying.

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
