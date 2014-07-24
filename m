From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 24 Jul 2014 14:07:43 +0200
Subject: [GIT PULL] Few regression fixes for omaps for v3.16-rc series
In-Reply-To: <20140724114348.GA29045@atomide.com>
References: <20140724114348.GA29045@atomide.com>
Message-ID: <5087610.iA71nMtfdT@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 24 July 2014 04:43:49 Tony Lindgren wrote:
> Two regression fixes for omaps and one fix for device signaling:
> 
> - L2 cache regression fix for a warning about trying to access
>   a read-only register
> 
> - GPMC ECC software fallback regression fix for omap3
> 
> - Fix for dra7 pinctrl pull-up direction that causes signal issues
>   for anybody trying to use the internal pull up or down
> 

Merged into the fixes branch, thanks!

	Arnd
