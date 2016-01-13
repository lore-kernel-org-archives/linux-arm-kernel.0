From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 Jan 2016 15:00:36 +0100
Subject: [PATCH] drm: nouveau: fix nouveau_debugfs_init prototype
In-Reply-To: <1503925101.39877.1452693347204.JavaMail.open-xchange@www.ud-mail.de>
References: <3968390.Pvmnq3v7oC@wuerfel>
 <1503925101.39877.1452693347204.JavaMail.open-xchange@www.ud-mail.de>
Message-ID: <12563536.Vhe8JJPi2x@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 January 2016 14:55:47 Karol Herbst wrote:
> > Arnd Bergmann <arnd@arndb.de> hat am 13. Januar 2016 um 14:48 geschrieben:
> > 
> > The new debugfs initialization code fails to build when CONFIG_DEBUG_FS
> > is disabled:
> > 
> > In file included from /git/arm-soc/drivers/gpu/drm/nouveau/nouveau_drm.c:57:0:
> > drivers/gpu/drm/nouveau/nouveau_debugfs.h: In function 'nouveau_debugfs_init':
> > drivers/gpu/drm/nouveau/nouveau_debugfs.h:37:29: error: parameter name omitted
> >  nouveau_debugfs_init(struct nouveau_drm *)
> > 
> > This fixes the prototypes so we can build it again.
> > 
> 
> thanks for this. I already send a patch to the nouveau ML here:
> http://lists.freedesktop.org/archives/nouveau/2016-January/023779.html

Ok, thanks

	Arnd
