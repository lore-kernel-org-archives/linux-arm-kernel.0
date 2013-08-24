From: m.chehab@samsung.com (Mauro Carvalho Chehab)
Date: Sat, 24 Aug 2013 15:48:26 -0300
Subject: [PATCH v5 0/3] R8A7779/Marzen R-Car VIN driver support
In-Reply-To: <5218E1CE.8050600@cogentembedded.com>
References: <201308230119.13783.sergei.shtylyov@cogentembedded.com>
 <20130823001140.GD9254@verge.net.au> <5218E1CE.8050600@cogentembedded.com>
Message-ID: <20130824154826.63c2cf6c@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Sat, 24 Aug 2013 20:39:42 +0400
Sergei Shtylyov <sergei.shtylyov@cogentembedded.com> escreveu:

> Hello.
> 
> On 08/23/2013 04:11 AM, Simon Horman wrote:
> 
> >>     [Resending with a real version #.]
> 
> >>     Here's the set of 3 patches against the Mauro's 'media_tree.git' repo's
> >> 'master' branch. Here we add the VIN driver platform code for the R8A7779/Marzen
> >> with ADV7180 I2C video decoder.
> 
> >> [1/3] ARM: shmobile: r8a7779: add VIN support
> >> [2/3] ARM: shmobile: Marzen: add VIN and ADV7180 support
> >> [3/3] ARM: shmobile: Marzen: enable VIN and ADV7180 in defconfig
> 
> >>      Mauro has kindly agreed to merge this patchset thru his tree to resolve the
> >> dependency on the driver's platform data header, provided that the maintainer
> >> ACKs this. Simon, could you ACK the patchset ASAP -- Mauro expects to close his
> >> tree for 3.12 this weekend or next Monday?
> 
> > All three patches:
> 
> > Acked-by: Simon Horman <horms+renesas@verge.net.au>
> 
>     Mauro, I see you have only merged the R8A7778/BOCK-W VIN series and didn't 
> merge this one, obsoleting its patches in patchwork instead. What's wrong with 
> them?

Sorry... as I saw v5 and v6 versions, one after the other, and both with VIN,
from you, I assumed that v6 were just an update over v5.

I re-tagged them as new. I'll handle them on a next spin this weekend.

Regards,
Mauro
