From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 24 Sep 2012 12:43:39 +0000
Subject: linux-next: manual merge of the arm-soc tree with the omap_dss2
 tree
In-Reply-To: <20120924195305.588277e94ce701abc5e5a6c5@canb.auug.org.au>
References: <20120924195305.588277e94ce701abc5e5a6c5@canb.auug.org.au>
Message-ID: <201209241243.39462.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 September 2012, Stephen Rothwell wrote:
> Today's linux-next merge of the arm-soc tree got a conflict in
> drivers/video/omap/lcd_ams_delta.c between commit 9586778de558 ("OMAPFB1:
> remove unnecessary includes") from the  tree and commit e27e35ec735f
> ("ARM: OMAP1: Move board-ams-delta.h from plat to mach") from the arm-soc
> tree.
> 
> The latter removed a superset of the former (as far as include files is
> concerned), so I used that and can carry the fix as necessary (no action
> is required).
> 

Hi Stephen,

I looked at all your reports and your fixes are looking good to me.

I'm already building all ARM defconfigs now and have fixup patches for the
instances that went wrong or introduced new warnings, I'll do that again
on top of today's linux-next tree.

The merge window is going to be fun with all those conflicts, but I don't
have a better idea either.

	Arnd
