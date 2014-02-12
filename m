From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 12 Feb 2014 17:54:42 +0100
Subject: [PATCH 4/4] ARM: Delete asm/system.h
In-Reply-To: <20140212154615.2405.88996.stgit@warthog.procyon.org.uk>
References: <20140212154544.2405.2992.stgit@warthog.procyon.org.uk>
 <20140212154615.2405.88996.stgit@warthog.procyon.org.uk>
Message-ID: <1559240.V3DW7mAybD@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 February 2014 15:46:15 David Howells wrote:
> Delete ARM's asm/system.h.  It's the last holdout and should be got rid of.
> 
> This builds for defconfig, lpc32xx_defconfig, exynos_defconfig + XEN, the
> previous changed to a Gemini system and an omap3 config with TI_DAVINCI_EMAC.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Russell King <linux@arm.linux.org.uk>
> cc: linux-arm-kernel at lists.infradead.org

Acked-by: Arnd Bergmann <arnd@arndb.de>

I've added this to my randconfig builder, will let you know when unexpected
bugs show up (probably won't).

	Arnd
