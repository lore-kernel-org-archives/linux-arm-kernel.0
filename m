From: horms@verge.net.au (Simon Horman)
Date: Fri, 16 Sep 2016 12:11:39 +0200
Subject: [PATCH] ARM: dts: wheat: add DU support
In-Reply-To: <ba5b2f8e-13f8-6c7d-17c1-44988d30a947@cogentembedded.com>
References: <34968644.DhifNderY8@wasted.cogentembedded.com>
 <15676050.WJW1jK1n2R@wasted.cogentembedded.com>
 <ba5b2f8e-13f8-6c7d-17c1-44988d30a947@cogentembedded.com>
Message-ID: <20160916101139.GI14562@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 12, 2016 at 08:52:40PM +0300, Sergei Shtylyov wrote:
> On 09/02/2016 12:29 AM, Sergei Shtylyov wrote:
> 
> >Define  the  Wheat board dependent  part of the DU device node.
> >Add the device nodes for the Analog Devices ADV7513 HDMI transmitters
> >connected to DU0/1.  Add the necessary subnodes to interconnect DU with
> >HDMI transmitters/connectors.
> >
> >Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> >
> >---
> >This patch is against the 'renesas-devel-20160901-v4.8-rc4' of Simon Horman's
> >'renesas.git' repo plus the Wheat CAN and SDHI patches posted earlier...
> >The path depends on the 2 DRM patches just posted in order to work correctly!
> 
>    In principle, both these patches have been queued by the maintainers...
> Simon, are you going to wait till they hit media_tree.git? Linus' tree?

I don't think that is necessary. I was waiting for some review.
But in any case it looks like this patch no longer applies cleanly.
Could you rebase?
