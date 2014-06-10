From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Jun 2014 16:09:14 +0200
Subject: [PATCH 2/2] ARM: use menuconfig for sub-arch menus
In-Reply-To: <1402409170-1314-3-git-send-email-robherring2@gmail.com>
References: <1402409170-1314-1-git-send-email-robherring2@gmail.com>
 <1402409170-1314-3-git-send-email-robherring2@gmail.com>
Message-ID: <7872085.1SSGOVbm1y@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 June 2014 09:06:10 Rob Herring wrote:
> From: Rob Herring <robh@kernel.org>
> 
> The System Type menu is getting quite long with platforms and is
> inconsistent in handling of sub-arch specific options. Tidy up the menu
> by making platform options a menuconfig entry containing any platform
> specific config items.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> 

Excellent! I actually have a similar patch in my queue of stuff to
look at again. If there are no objections, I'd prefer to queue yours
up as a fix for 3.16.

	Arnd
