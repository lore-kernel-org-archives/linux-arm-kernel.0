From: balbi@ti.com (Felipe Balbi)
Date: Wed, 29 Jun 2011 12:30:34 +0300
Subject: [PATCH] AT91: add AT91SAM9X5 dummy configuration variable
In-Reply-To: <20110628160252.GQ17355@game.jcrosoft.org>
References: <1309260927-11411-1-git-send-email-nicolas.ferre@atmel.com>
	<20110628103549.GG2612@legolas.emea.dhcp.ti.com>
	<4E09C573.2030607@atmel.com>
	<20110628122650.GK2612@legolas.emea.dhcp.ti.com>
	<20110628160252.GQ17355@game.jcrosoft.org>
Message-ID: <20110629093033.GB2760@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jun 28, 2011 at 06:02:52PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > yet you will prevent the driver from being easily used by other
> > architectures. What will happen is that a certain amount of:
> > 
> > depends on (ARCH_AT91SAM9X5 || ARCH_FOO || ARCH_BAR || ARCH_BAZ)
> no I disagree this is done to allow only the drivers on proper arch
> 
> and we do not need the multiple depend we usally create a HAVE_xxx config
> that the ARCH select and we just depend on it

I still think it isn't good enough. Ideally, drivers will always be
portable without any arch dependency or the HAVE_XXX trick. Still, it's
not worth to continue this discussion, I rather look at a driver which
now depends on ARCH_AT91SAM9X5.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110629/2806b1c1/attachment.sig>
