From: moinejf@free.fr (Jean-Francois Moine)
Date: Mon, 5 Aug 2013 12:13:07 +0200
Subject: [PATCH RFC 06/13] ASoC: kirkwood: combine kirkwood-i2s and
 kirkwood-dma drivers
In-Reply-To: <E1V63xH-0004lZ-TX@rmk-PC.arm.linux.org.uk>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
 <E1V63xH-0004lZ-TX@rmk-PC.arm.linux.org.uk>
Message-ID: <20130805121307.555cb419@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 04 Aug 2013 20:27:03 +0100
Russell King <rmk+kernel@arm.linux.org.uk> wrote:

> These really should be a single driver because they're fully integrated
> in hardware.  Make them so.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/mach-dove/common.c          |    4 ++--
>  arch/arm/mach-kirkwood/common.c      |   24 +++++++++---------------
>  sound/soc/kirkwood/Kconfig           |    5 -----
>  sound/soc/kirkwood/Makefile          |    4 +---
>  sound/soc/kirkwood/kirkwood-dma.c    |   30 +-----------------------------
>  sound/soc/kirkwood/kirkwood-i2s.c    |   21 ++++++++++++++++-----
>  sound/soc/kirkwood/kirkwood-openrd.c |    4 ++--
>  sound/soc/kirkwood/kirkwood-t5325.c  |    4 ++--
>  sound/soc/kirkwood/kirkwood.h        |    2 ++
>  9 files changed, 35 insertions(+), 63 deletions(-)
	[snip]

Glad to see you got my patch, but why did you changed all the names?

Replacing "kirkwood-pcm-audio" by "kirkwood-i2s" should be enough.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
