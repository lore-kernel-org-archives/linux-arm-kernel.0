From: hs@denx.de (Heiko Schocher)
Date: Mon, 21 Jan 2013 22:37:13 +0100
Subject: [PATCH 11/15] mtd: davinci_nand: fix OF support
In-Reply-To: <1358788568-11137-12-git-send-email-arnd@arndb.de>
References: <1358788568-11137-1-git-send-email-arnd@arndb.de>
 <1358788568-11137-12-git-send-email-arnd@arndb.de>
Message-ID: <50FDB509.9030004@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

On 21.01.2013 18:16, Arnd Bergmann wrote:
> The patch cdeadd "mtd: nand: davinci: add OF support for
> davinci nand controller" ironically causes a build error
> when CONFIG_OF is enabled because of a missing ';'
> character:
> 
> drivers/mtd/nand/davinci_nand.c:527:1: error: expected ',' or ';' before 'extern'
> 
> This is the obvious fix.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Heiko Schocher <hs@denx.de>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> Cc: David Woodhouse <David.Woodhouse@intel.com>
> ---
>  drivers/mtd/nand/davinci_nand.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Already fixed here:
http://lists.infradead.org/pipermail/linux-mtd/2013-January/045366.html

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
