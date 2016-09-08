From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 8 Sep 2016 11:57:46 +0200
Subject: [PATCH 5/6] ARM: dts: Add NextThing GR8 dtsi
In-Reply-To: <CABxcv=kJCuP==QVRqyuoORSoWKAEqXmt5iRjdvDcCcr4MSm0gQ@mail.gmail.com>
References: <20160831081817.5191-1-maxime.ripard@free-electrons.com>
 <20160831081817.5191-6-maxime.ripard@free-electrons.com>
 <CABxcv=kJCuP==QVRqyuoORSoWKAEqXmt5iRjdvDcCcr4MSm0gQ@mail.gmail.com>
Message-ID: <20160908095746.GN8913@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

On Wed, Sep 07, 2016 at 04:51:55PM +0200, Javier Martinez Canillas wrote:
> Hello Maxime,
> 
> On Wed, Aug 31, 2016 at 10:18 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> 
> [snip]
> 
> > +
> > +#include "skeleton.dtsi"
> > +
> 
> The skeleton.dtsi has been deprecated and shouldn't be used in new DTS files:
> 
> http://www.spinics.net/lists/arm-kernel/msg528080.html

Ok, thanks, I'll change it in the v3.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160908/d7268678/attachment.sig>
