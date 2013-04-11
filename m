From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 11 Apr 2013 18:19:38 +0100
Subject: [PATCH 18/30] ASoC: samsung: move plat/ headers to local directory
In-Reply-To: <201304111908.42532.arnd@arndb.de>
References: <1365638712-1028578-1-git-send-email-arnd@arndb.de>
 <1365638712-1028578-19-git-send-email-arnd@arndb.de>
 <20130411164751.GK9243@opensource.wolfsonmicro.com>
 <201304111908.42532.arnd@arndb.de>
Message-ID: <20130411171938.GS9243@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 11, 2013 at 07:08:42PM +0200, Arnd Bergmann wrote:
> On Thursday 11 April 2013, Mark Brown wrote:

> > This doesn't apply to my topic/samsung branch, can you please regenerate
> > it against that or let me know what to apply it against?

> This one should work. Unfortunately I now found during testing that the
> s3c24xx sound support has a few build errors at the moment, but this
> patch should not add any new ones:

Applied (after hand editing the commit message), thanks.

> make[5]: *** [sound/soc/samsung/i2s.o] Error 1
> /git/arm-soc/sound/soc/samsung/neo1973_wm8753.c:25:24: fatal error: mach/gta02.h: No such file or directory
>  #include <mach/gta02.h>

Hrm, someone killed GTA02 support?  That's sad...  if that's really the
case we could kill the machine driver but not tonight as I'm running
late...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130411/bfb89cc1/attachment.sig>
