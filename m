From: horms@verge.net.au (Simon Horman)
Date: Wed, 1 Jun 2016 10:21:53 +0900
Subject: [PATCH 12/13] ARM: dts: blanche: initial device tree
In-Reply-To: <1923946.Jvi0TDUXFC@wasted.cogentembedded.com>
References: <13205049.n7pM8utpHF@wasted.cogentembedded.com>
 <1923946.Jvi0TDUXFC@wasted.cogentembedded.com>
Message-ID: <20160601012153.GK20527@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 01, 2016 at 01:32:35AM +0300, Sergei Shtylyov wrote:
> Add the initial device  tree for the R8A7792 SoC based Blanche board.
> The board has 2 debug serial ports: SCIF0 and SCIF3; include support for
> them,  so that  the serial console  can  work.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

At this time I do not have access to documentation or hardware for this
board. So I am relying on you to test this and make sure it complies
with the spec.

What you have looks reasonable to me:

Acked-by: Simon Horman <horms+renesas@verge.net.au>
