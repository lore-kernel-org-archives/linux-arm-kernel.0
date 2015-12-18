From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 18 Dec 2015 18:14:19 +0200
Subject: OMAP display kconfig options changing
In-Reply-To: <20151218160514.GK23396@atomide.com>
References: <5673CA0D.4000706@ti.com> <20151218135342.GF23396@atomide.com>
 <56741FA9.3080607@ti.com> <20151218160514.GK23396@atomide.com>
Message-ID: <567430DB.4000507@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/12/15 18:05, Tony Lindgren wrote:

>> Are you referring to Kconfig options? Or userspace?
> 
> Well sounds like both need updating :)

Depends... For simple fb apps, omapdrm works fine, and X with the
standard fbdev driver should work with omapdrm too.

But if the userspace is using any omapfb specific apps, then yes, update
is necessary.

>> But no, I don't have links to either.
> 
> So change the Kconfig options and then deal with the flood
> of angry emails? :) I think we need instructions..

Ok. I think it's then best that I just update the defconfig to enable
omapfb as modules, as it is currently.

We can look again at changing the default to omapdrm after we've tested
it on OMAP2 too, and we have a better idea what the user needs to take
care of.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151218/1ca25916/attachment-0001.sig>
