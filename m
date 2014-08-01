From: tony@atomide.com (Tony Lindgren)
Date: Fri, 1 Aug 2014 01:21:41 -0700
Subject: [PATCH 0/2] Manage OMAP34xx ES3.1.2 rev to resume from suspend
In-Reply-To: <1406812234-23163-1-git-send-email-jvial@adeneo-embedded.com>
References: <1406812234-23163-1-git-send-email-jvial@adeneo-embedded.com>
Message-ID: <20140801082140.GA26699@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jeremy Vial <jvial@adeneo-embedded.com> [140731 06:16]:
> Hi,
> 
> My kernel crashed when my OMAP34xx ES3.1.2 leave suspend mode. The first
> patch seems to solve the issue, and the second one corrects Linux kernel
> coding style problems.
> 
> Jeremy Vial (2):
>   ARM: OMAP3: Fix choice of omap3_restore_es function in OMAP34XX
>     rev3.1.2 case.
>   ARM: OMAP3: Fix coding style problems in
>     arch/arm/mach-omap2/control.c
> 
>  arch/arm/mach-omap2/control.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Thanks applying these fixes for the merge window. I've tagged
the first patch also for stable.

Regards,

Tony
