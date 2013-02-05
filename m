From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 5 Feb 2013 16:31:40 +0000
Subject: [PATCH] OMAPDSS: enable omapdss for ARCH_MULTIPLATFORM
In-Reply-To: <201301222153.19580.arnd@arndb.de>
References: <1358891160-9534-1-git-send-email-robdclark@gmail.com>
 <201301222153.19580.arnd@arndb.de>
Message-ID: <201302051631.40254.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 January 2013, Arnd Bergmann wrote:
> On Tuesday 22 January 2013, Rob Clark wrote:
> > At least core omapdss does not have any build dependencies on
> > ARCH_OMAP2PLUS, and adding this dependency in the Kconfig breaks omapdrm
> > for ARCH_MULTIPLATFORM builds.
> > 
> > Signed-off-by: Rob Clark <robdclark@gmail.com>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

It seems nobody has applied this patch, as it has not shown up in
linux-next or upstream. Who should take care of this? If nobody feels
responsible, I can put it into arm-soc/fixes.

	Arnd
