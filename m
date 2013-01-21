From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 21 Jan 2013 20:09:57 +0000
Subject: [PATCH 15/15] staging/omapdrm: don't build on multiplatform
In-Reply-To: <50FD8B63.1060506@ti.com>
References: <1358788568-11137-1-git-send-email-arnd@arndb.de>
 <201301211741.11875.arnd@arndb.de> <50FD8B63.1060506@ti.com>
Message-ID: <201301212009.58198.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 January 2013, Rob Clark wrote:
> ahh, ok, I see.. the if ARCH_OMAP2PLUS bit looks like it came in 
> recently (770b6cb)
> 
> what about changing this to 'if ARCH_OMAP2PLUS || ARCH_MULTIPLATFORM'?

Fine with me in general, but the patch I posted would be the more
conservative choice for v3.8.

	Arnd
