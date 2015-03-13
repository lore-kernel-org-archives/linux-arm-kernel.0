From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 13 Mar 2015 23:04:49 +0100
Subject: [PATCH v3 0/7] Switch mach-at91 to multiplatform
In-Reply-To: <1426283844-463-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1426283844-463-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20150313220449.GN4329@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas,

On 13/03/2015 at 22:57:17 +0100, Alexandre Belloni wrote :
> AT91 is now ready to switch to multiplatform. Do it and clean the remaining mach
> includes.
> 
> Changes in v3:
>  - use a menu structure as asked by Arnd
>  - remove useless selects as pointed by Rob
>  - drop a patch that has already been applied
>  - add a patch to remove AT91_TIMER_HZ

I forgot to add that I rebased it on your at91-4.1-cleanup branch as the
merge conflict in arch/arm/mach-at91/Kconfig was not easy to solve.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
