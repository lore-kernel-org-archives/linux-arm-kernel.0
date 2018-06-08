From: horms@verge.net.au (Simon Horman)
Date: Fri, 8 Jun 2018 10:56:56 +0200
Subject: [PATCH v2 1/5] arm64: dts: renesas: r8a77980: add FCPVD support
In-Reply-To: <73f61c34-d0ec-75cd-b6fd-a41cfb39078f@cogentembedded.com>
References: <390fabf0-4caf-1600-3780-1893207d94f7@cogentembedded.com>
 <73f61c34-d0ec-75cd-b6fd-a41cfb39078f@cogentembedded.com>
Message-ID: <20180608085656.lulmpodu4rytcda7@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 07, 2018 at 11:19:31PM +0300, Sergei Shtylyov wrote:
> Describe FCPVD0 in the R8A77980 device tree; it will be used by VSPD0 in
> the next patch...
> 
> Based on the original (and large) patch by Vladimir Barinov.
> 
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Hi,

This looks fine to me but I will wait for the dependencies of this series
to land and to see if there are other reviews before applying.

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
