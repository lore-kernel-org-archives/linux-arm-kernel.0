From: horms@verge.net.au (Simon Horman)
Date: Thu, 30 Jun 2016 14:27:18 +0200
Subject: [PATCH] ARM: dts: r8a7792: add SMP support
In-Reply-To: <7c23396f-f880-40ac-654d-cffc82df021e@cogentembedded.com>
References: <14666252.G84Ipxe6EL@wasted.cogentembedded.com>
 <1627631.X1bJtVQHBF@wasted.cogentembedded.com>
 <7c23396f-f880-40ac-654d-cffc82df021e@cogentembedded.com>
Message-ID: <20160630122718.GA24035@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 29, 2016 at 07:46:33PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 06/21/2016 01:31 AM, Sergei Shtylyov wrote:
> 
> >Add the device tree nodes for the Advanced Power Management Unit (APMU)
> >and the second Cortex-A15 CPU core.
> >Use the "enable-method" prop  to point out that the APMU should be used
> >for the SMP support.
> >
> >Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> >
> >---
> >This patch is against the 'renesas-devel-20160620-v4.7-rc4' tag of Simon
> >Horman's 'renesas.git' repo.  It depends on Magnus'/Geert's SMP patchset...
> 
>    simon, now that this patchset has been merged (for 4.8?), could you also
> merge this patch?

Sure, as this is for a new board I'll make a last minute exception and take
this. I am trusting that cpu hotplug and suspend/resume have been adequately
tested.
