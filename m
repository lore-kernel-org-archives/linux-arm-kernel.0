From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 26 Feb 2016 22:43:27 +0300
Subject: [PATCH] ARM: dts: porter: remove enable prop from HS-USB device
 node
In-Reply-To: <2684686.0L09MeB6pA@wasted.cogentembedded.com>
References: <1674850.BZpGW9kEud@wasted.cogentembedded.com>
 <2684686.0L09MeB6pA@wasted.cogentembedded.com>
Message-ID: <56D0AADF.6090201@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/14/2016 01:26 AM, Sergei Shtylyov wrote:

> In  the final versions of the Porter board (called "PORTER_C") Renesas
> decided to get rid  of the Maxim Integrated MAX3355 OTG chip and didn't
> add any other provision to differ the host/gadget mode, so we'll have to
> remove  no longer valid "renesas,enable-gpio" property from the HS-USB
> device node.  Hopefully, the earlier revisions of the board were never
> seen in the wild...
>
> Fixes: c794f6a09a25 ("ARM: shmobile: porter: add HS-USB DT support")
> Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

    Simon, what about this patch? It was posted 12 days ago and no reaction 
whatsoever...

MBR, Sergei
