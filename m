From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 Jun 2014 16:07:27 +0200
Subject: [PATCH 2/2] ARM: use menuconfig for sub-arch menus
In-Reply-To: <7872085.1SSGOVbm1y@wuerfel>
References: <1402409170-1314-1-git-send-email-robherring2@gmail.com>
 <1402409170-1314-3-git-send-email-robherring2@gmail.com>
 <7872085.1SSGOVbm1y@wuerfel>
Message-ID: <201406131607.27682.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 June 2014, Arnd Bergmann wrote:
> On Tuesday 10 June 2014 09:06:10 Rob Herring wrote:
> > From: Rob Herring <robh@kernel.org>
> > 
> > The System Type menu is getting quite long with platforms and is
> > inconsistent in handling of sub-arch specific options. Tidy up the menu
> > by making platform options a menuconfig entry containing any platform
> > specific config items.
> > 
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > 
> 
> Excellent! I actually have a similar patch in my queue of stuff to
> look at again. If there are no objections, I'd prefer to queue yours
> up as a fix for 3.16.
> 


Queued both now in the fixes branch

	Arnd
