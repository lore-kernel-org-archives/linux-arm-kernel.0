From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 16 Jul 2015 05:43:24 +0000 (UTC)
Subject: [PATCH 2/2] ARM: OMAP2+: sparse: add missing function declarations
In-Reply-To: <3cb0fd46a493d80fad4d03316cdd6fb67a1938b7.1436622578.git.nsekhar@ti.com>
References: <cover.1436622578.git.nsekhar@ti.com>
 <3cb0fd46a493d80fad4d03316cdd6fb67a1938b7.1436622578.git.nsekhar@ti.com>
Message-ID: <alpine.DEB.2.02.1507160543100.32764@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 11 Jul 2015, Sekhar Nori wrote:

> omap3xxx_restart() and omap44xx_restart() are global
> functions declared in common.h. Include this file
> in omap3-restart.c and omap4-restart.c to prevent
> sparse warnings of type:
> 
> arch/arm/mach-omap2/omap4-restart.c:22:6: warning: symbol 'omap44xx_restart' was not declared. Should it be static?
> 
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>

Thanks, queued for v4.3.

- Paul
