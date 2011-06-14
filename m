From: tony@atomide.com (Tony Lindgren)
Date: Tue, 14 Jun 2011 04:47:32 -0700
Subject: Regulator cleanups in mach-omap2, take three
In-Reply-To: <1307386628-1153-1-git-send-email-green@linuxhacker.ru>
References: <1307386628-1153-1-git-send-email-green@linuxhacker.ru>
Message-ID: <20110614114732.GR3352@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* green at linuxhacker.ru <green@linuxhacker.ru> [110606 11:54]:
> Hello!
> 
>   This is yet another attempt at some regulator cleanups in mach-omap2 code:
>   Convert all users to REGULATOR_SUPPLY init style and drop the old-style
>   .dev assignment common ins hs_mmc init.
> 
>   I made a test compile and all the individual board files changed compile
>   (I don't have the devices themselves, but similar changes to my
>    device board file are working).
> 
>   For the pandaboard changes - I am not sure what the proper names for those
>   devices would be, so only converted the regulator to array.
> 
>   Big changes since v2:
>   Per Felipe Balbi request converted all regulator supplies to arrays
>   just in case.
>   Also nuked an unneeded comment in cm-t35 board left after mmc.dev
>   assignment removal.

Thanks, applying to devel-cleanup branch for next merge window.

Tony
