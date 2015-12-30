From: broonie@kernel.org (Mark Brown)
Date: Wed, 30 Dec 2015 16:33:07 +0000
Subject: [PATCH 4/6] regulator: lp872x: Add enable GPIO pin support
In-Reply-To: <1451464521.2531.4.camel@collins>
References: <1450868319-20513-1-git-send-email-contact@paulk.fr>
 <1450868319-20513-5-git-send-email-contact@paulk.fr>
 <20151223115632.GS16023@sirena.org.uk> <568088B4.6090207@ti.com>
 <1451342963.14631.13.camel@collins> <5681D7A8.2030101@ti.com>
 <1451387613.18148.9.camel@collins> <568323B7.7080101@ti.com>
 <1451464521.2531.4.camel@collins>
Message-ID: <20151230163307.GW16023@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 30, 2015 at 09:35:21AM +0100, Paul Kocialkowski wrote:

> In my opinion, it would be more elegant to adapt the core regulator
> framework to first enable the GPIO and then call the regulator enable
> ops callback instead of handling the GPIO in the driver.

Why would we want to actively manage both things at runtime?  It's more
work, what do we gain from it?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151230/c9d94e37/attachment.sig>
