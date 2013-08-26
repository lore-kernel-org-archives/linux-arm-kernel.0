From: tony@atomide.com (Tony Lindgren)
Date: Mon, 26 Aug 2013 04:17:08 -0700
Subject: [GIT PULL] ARM: OMAP: miscellaneous PRCM and hwmod updates for
 v3.12
In-Reply-To: <alpine.DEB.2.02.1308231932400.22768@utopia.booyaka.com>
References: <alpine.DEB.2.02.1308231932400.22768@utopia.booyaka.com>
Message-ID: <20130826111708.GD7656@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [130823 12:40]:
> Hi Tony
> 
> The following changes since commit b36f4be3de1b123d8601de062e7dbfc904f305fb:
> 
>   Linux 3.11-rc6 (2013-08-18 14:36:53 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.12/omap-prcm-hwmod
> 
> for you to fetch changes up to 4514b4d7fcad2a84066c73966c6a7823ea1b3749:
> 
>   Merge branches 'hwmod_devel_v3.12', 'prcm_devel_v3.12' and 'am33xx_devel_v3.12' into prcm_a_for_v3.12 (2013-08-23 12:49:48 -0600)
> 
> ----------------------------------------------------------------
> 
> Various OMAP PRCM & hwmod fixes and improvements.  Notable changes
> include:
> 
> - a fix for OMAP4 PLL locking to avoid a bootloader dependency that
>   causes nasty log spew on startup
> 
> - AM33xx DEBUGSS support fixes in hwmod data
> 
> - OMAP5 mailbox support in hwmod data
> 
> Basic test logs are here:
> 
> http://www.pwsan.com/omap/testlogs/prcm_a_for_v3.12/20130823125002/
> 
> Note that the 3530 failure is due to the mysterious transient serial
> issue affecting 3530 for several releases now, which causes a log
> parsing failure.  PM still seems to work.

Thanks pulling into omap-for-v3.12/prcm.

Regards,

Tony
