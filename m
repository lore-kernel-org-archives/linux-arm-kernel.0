From: balbi@ti.com (Felipe Balbi)
Date: Wed, 8 Oct 2014 13:22:05 -0500
Subject: [PATCH v3 2/3] ARM: shmobile: koelsch: enable HS-USB
In-Reply-To: <54357E6F.1080702@cogentembedded.com>
References: <1511869.4ca9KHmSFr@wasted.cogentembedded.com>
 <8674731.7YYzQeH0h1@wasted.cogentembedded.com>
 <20141008180513.GJ22688@saruman>
 <54357D76.4050104@cogentembedded.com>
 <20141008180852.GK22688@saruman>
 <54357E6F.1080702@cogentembedded.com>
Message-ID: <20141008182205.GL22688@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 08, 2014 at 10:11:59PM +0400, Sergei Shtylyov wrote:
> On 10/08/2014 10:08 PM, Felipe Balbi wrote:
> 
> >>>>From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> 
> >>>>Enable HS-USB device for the Koelsch board, defining the GPIO that the driver
> >>>>should check when probing (which is the ID output from MAX3355 OTG chip).
> 
> >>>>Note that there will be pinctrl-related error messages if both internal PCI
> >>>>and HS-USB drivers are enabled but they should be just ignored.
> 
> >>>>Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> >>>>[Sergei: added pin function/group and prop, moved device node, fixed summary,
> >>>>added changelog]
> >>>>Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> >>>>---
> >>>>Changes in version 3:
> >>>>- added pinctrl-related properties;
> 
> >>>did you miss pinctrl here ?
> 
> >>     No, AFAICS. Or what do you mean?
> 
> >usb0_pins doesn't appear to be defined anywhere.
> 
>    They are defined in the same file, just not in this patch. If you're
> looking at some of the USB trees or Linus' tree, the corresponding patch
> just hasn't hit them yet, it's in renesas.git ATM.

oh, alright then. :-)

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141008/0243b3db/attachment.sig>
