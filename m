From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 14 Mar 2015 11:23:18 +0100
Subject: [PATCH v3 0/7] Switch mach-at91 to multiplatform
In-Reply-To: <1426283844-463-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1426283844-463-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <2957715.PVTpiODd1f@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 13 March 2015 22:57:17 Alexandre Belloni wrote:
> AT91 is now ready to switch to multiplatform. Do it and clean the remaining mach
> includes.
> 
> Changes in v3:
>  - use a menu structure as asked by Arnd
>  - remove useless selects as pointed by Rob
>  - drop a patch that has already been applied
>  - add a patch to remove AT91_TIMER_HZ
> 
> 

Looks all good to me. Are there any headers left in include/mach that
can be moved to mach-at91, or does this cover all of them?

	Arnd
