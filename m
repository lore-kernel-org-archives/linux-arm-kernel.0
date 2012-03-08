From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 8 Mar 2012 16:16:12 +0000
Subject: linux-next: manual merge of the arm-soc tree with the omap_dss2
 tree
In-Reply-To: <20120308170048.f1a992bca2ca2d93fa9747bf@canb.auug.org.au>
References: <20120308170048.f1a992bca2ca2d93fa9747bf@canb.auug.org.au>
Message-ID: <201203081616.12510.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 March 2012, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the arm-soc tree got a conflict in
> arch/arm/mach-omap1/board-palmtt.c between commit ddba6c7f7ec6 ("OMAP1:
> pass LCD config with omapfb_set_lcd_config()") from the omap_dss2 tree
> and commit 2e3ee9f45b3c ("ARM: OMAP1: Move most of plat/io.h into local
> iomap.h") from the arm-soc tree.
> 
> I fixed it up (see below) and can carry the fix as necessary.

Hi Stephen,

Thanks for fixing up all the conflicts between arm-soc and omap_dss2.
I think we should make sure they are resolved in one of the trees before
the merge window.

Tomi, what are your plans for the omap_dss2 branch to get merged?
Do you think you should send it to Linus first and we merge it into
arm-soc to resolve the conflicts?
Or do you want to merge it through the arm-soc tree?
Or should we go first and you fix up the conflicts by pulling in the
necessary topic branches from arm-soc into your tree?

	Arnd
