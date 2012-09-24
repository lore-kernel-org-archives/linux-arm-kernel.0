From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 24 Sep 2012 16:11:46 +0300
Subject: linux-next: manual merge of the arm-soc tree with the omap_dss2
 tree
In-Reply-To: <201209241243.39462.arnd@arndb.de>
References: <20120924195305.588277e94ce701abc5e5a6c5@canb.auug.org.au>
 <201209241243.39462.arnd@arndb.de>
Message-ID: <1348492306.2361.48.camel@deskari>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Mon, 2012-09-24 at 12:43 +0000, Arnd Bergmann wrote:
> On Monday 24 September 2012, Stephen Rothwell wrote:
> > Today's linux-next merge of the arm-soc tree got a conflict in
> > drivers/video/omap/lcd_ams_delta.c between commit 9586778de558 ("OMAPFB1:
> > remove unnecessary includes") from the  tree and commit e27e35ec735f
> > ("ARM: OMAP1: Move board-ams-delta.h from plat to mach") from the arm-soc
> > tree.
> > 
> > The latter removed a superset of the former (as far as include files is
> > concerned), so I used that and can carry the fix as necessary (no action
> > is required).
> > 
> 
> Hi Stephen,
> 
> I looked at all your reports and your fixes are looking good to me.
> 
> I'm already building all ARM defconfigs now and have fixup patches for the
> instances that went wrong or introduced new warnings, I'll do that again
> on top of today's linux-next tree.
> 
> The merge window is going to be fun with all those conflicts, but I don't
> have a better idea either.

If there's a stable branch for the OMAP platform changes, I could merge
it to omapdss tree and fix the conflicts. But if I've understood right,
Linus doesn't really like merges just for the sake of fixing conflicts.

So far all the omapdss conflicts seem trivial, though.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120924/42ef092e/attachment.sig>
