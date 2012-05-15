From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 May 2012 20:03:33 +0000
Subject: [GIT PULL][Update] Renesas ARM-based platforms: new boards
 support for v3.5
In-Reply-To: <201205151749.59846.rjw@sisk.pl>
References: <201205112101.59949.rjw@sisk.pl>
 <201205151530.18193.arnd@arndb.de> <201205151749.59846.rjw@sisk.pl>
Message-ID: <201205152003.33393.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 May 2012, Rafael J. Wysocki wrote:
> On Tuesday, May 15, 2012, Arnd Bergmann wrote:
> > On Tuesday 15 May 2012, Arnd Bergmann wrote:
> > > On Monday 14 May 2012, Rafael J. Wysocki wrote:
> > I got build errors with the new version now because machine_is_kzm9g is no longer
> > defined:
> > 
> > /home/arnd/linux-arm/arch/arm/mach-shmobile/platsmp.c: In function 'shmobile_smp_get_core_count':
> > /home/arnd/linux-arm/arch/arm/mach-shmobile/platsmp.c:29:2: error: implicit declaration of function 'of_machine_is_compatible' [-Werror=implicit-function-declaration]
> > 
> > I'd apply the patch below, unless someone has a better solution
> 
> Please apply and thanks for the fix!
> 

Ok, applied now.

	Arnd
