From: balbi@ti.com (Felipe Balbi)
Date: Tue, 28 Jun 2011 13:35:50 +0300
Subject: [PATCH] AT91: add AT91SAM9X5 dummy configuration variable
In-Reply-To: <1309260927-11411-1-git-send-email-nicolas.ferre@atmel.com>
References: <1309260927-11411-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20110628103549.GG2612@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2011 at 01:35:27PM +0200, Nicolas Ferre wrote:
> Add this Kconfig variable to ease the submission of this chip support.
> As this chip/board inclusion is dealayed due to deep consolidation of
> arm/mach-at91 sources, we include this dummy configuration variable to allow
> submission of SAM9x5 related drivers in other subsystems.

Why are the drivers even depending on this ? They should be portable
enough. Can you share a few drivers so we have a look ?

IMHO, the whole idea of the consolidation is beyond arch/arm, drivers
should be affected too.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110628/46dfaa3e/attachment.sig>
