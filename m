From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 12 Sep 2012 16:05:04 +0000 (UTC)
Subject: [GIT PULL] ARM: OMAP2+: PRCM/hwmod: some fixes for 3.6-rc
In-Reply-To: <50498170.3010600@ti.com>
References: <alpine.DEB.2.00.1209051613580.11516@utopia.booyaka.com>
 <50498170.3010600@ti.com>
Message-ID: <alpine.DEB.2.00.1209121539360.17903@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 7 Sep 2012, Vaibhav Hiremath wrote:

> Isn't below patch good for -rc candidate (so as part of this 'fixes')?
> 
> ARM: OMAP2+: dpll: Add missing soc_is_am33xx() check for common functions
> 
> https://patchwork.kernel.org/patch/1371611/

It was queued for 3.7 because it didn't seem critical, since mainline 
wasn't booting anyway on AM33xx without the hwmod data.  Just sent the 
pull request for it:

http://marc.info/?l=linux-omap&m=134746561028888&w=2



- Paul
