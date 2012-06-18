From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 18 Jun 2012 18:04:08 +0100
Subject: [PATCH 1/2] sound: tegra_wm8903: Adjust to of_get_named_gpio()
 change
In-Reply-To: <4FDF5E9E.6060803@antcom.de>
References: <1340037743-12924-1-git-send-email-stigge@antcom.de>
 <20120618164659.GV3974@opensource.wolfsonmicro.com>
 <4FDF5E9E.6060803@antcom.de>
Message-ID: <20120618170408.GW3974@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2012 at 07:00:14PM +0200, Roland Stigge wrote:

> Basically, yes. But this would mean that doing via gpio, we would need
> to pull other stuff from the sound tree over to gpio to build upon
> because "my" tegra_* sound patches won't apply to the gpio branch currently.

Oh, yes.  Stephen's gone and reorganised all that code which means it's
not a trivial merge.  Ho hum.  I'm happy to apply them if folks are
comfortable with it, I guess ideally I'd be able to pull a branch with
the gpio changes in and then apply on top of that.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120618/135b3d89/attachment.sig>
