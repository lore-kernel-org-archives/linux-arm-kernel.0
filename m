From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 14 Jun 2013 11:17:05 +0300
Subject: [RFC PATCH 1/4] arm: omap: Add phy binding info for musb in plat
 data
In-Reply-To: <20130614073314.GA20992@atomide.com>
References: <1368796954-3499-1-git-send-email-kishon@ti.com>
 <51A43E0A.8090201@ti.com> <51B9C3B6.1080707@ti.com> <51BAABB0.5060107@ti.com>
 <20130614054720.GL8164@atomide.com> <51BAB9EA.5090805@ti.com>
 <20130614073314.GA20992@atomide.com>
Message-ID: <51BAD181.3020902@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/06/13 10:33, Tony Lindgren wrote:

> If we want to fix something this late in the merge window, the patches
> must have a clear description what caused the regression and what happens
> without the patches. These patches don't have that. And they are marked
> RFC also. So actually I'm not applying any of them before the regression
> descriptions are there and the patches have been reposted without RFC
> and have sufficient acks from people.

No disagreement there.

Kishon, I tested the patches on top of v3.10-rc5, booting with nfs root
via usb gadget eth:

Overo: works
Beagle: works, but I need to reconnect the usb cable after kernel is up
Beagle-xm: doesn't work. The cable is detected correctly, though
Panda: works

The problems with Beagles are there even without these patches, so they
do make things better (fix Overo).

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130614/152e5240/attachment.sig>
