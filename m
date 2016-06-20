From: horms@verge.net.au (Simon Horman)
Date: Mon, 20 Jun 2016 17:35:37 +0900
Subject: [PATCH] ARM: dts: silk: add DU pins
In-Reply-To: <f9aee8b5-7f78-acd0-e544-3d5977c01246@cogentembedded.com>
References: <1674850.BZpGW9kEud@wasted.cogentembedded.com>
 <2415333.mtLdVEoB2G@wasted.cogentembedded.com>
 <f9aee8b5-7f78-acd0-e544-3d5977c01246@cogentembedded.com>
Message-ID: <20160620083537.GF17292@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 17, 2016 at 11:53:21PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 04/13/2016 10:36 PM, Sergei Shtylyov wrote:
> 
> >Add the (previously omitted) DU pin data to the SILK board's device tree.
> >
> >Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> >
> >---
> >This patch is against the 'renesas-devel-20160411-v4.6-rc3' tag of Simon
> >Horman's 'renesas.git' repo. It depends on the R8A7794 DU PFC driver patch
> >just posted for the pins to be configured...
> 
>    Simon, this patch seems stuck while the PFC driver patch hit Linus' tree
> long ago. :-(

Thanks, I have queued it up.
