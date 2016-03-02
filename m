From: horms@verge.net.au (Simon Horman)
Date: Wed, 2 Mar 2016 09:47:50 +0900
Subject: [PATCH] ARM: dts: porter: remove enable prop from HS-USB device
 node
In-Reply-To: <56D0AADF.6090201@cogentembedded.com>
References: <1674850.BZpGW9kEud@wasted.cogentembedded.com>
 <2684686.0L09MeB6pA@wasted.cogentembedded.com>
 <56D0AADF.6090201@cogentembedded.com>
Message-ID: <20160302004750.GA26508@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 26, 2016 at 10:43:27PM +0300, Sergei Shtylyov wrote:
> On 02/14/2016 01:26 AM, Sergei Shtylyov wrote:
> 
> >In  the final versions of the Porter board (called "PORTER_C") Renesas
> >decided to get rid  of the Maxim Integrated MAX3355 OTG chip and didn't
> >add any other provision to differ the host/gadget mode, so we'll have to
> >remove  no longer valid "renesas,enable-gpio" property from the HS-USB
> >device node.  Hopefully, the earlier revisions of the board were never
> >seen in the wild...
> >
> >Fixes: c794f6a09a25 ("ARM: shmobile: porter: add HS-USB DT support")
> >Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> >Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
>    Simon, what about this patch? It was posted 12 days ago and no reaction
> whatsoever...

Hi Sergei,

sorry for the extended delay. I have queued this up as a fix for v4.5.
