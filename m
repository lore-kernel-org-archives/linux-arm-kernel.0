From: tony@atomide.com (Tony Lindgren)
Date: Thu, 6 Oct 2011 12:58:42 -0700
Subject: [PATCH v2 0/2] arm: omap4: hsmmc: pbias fixes
In-Reply-To: <1317644571-25175-1-git-send-email-balajitk@ti.com>
References: <1317644571-25175-1-git-send-email-balajitk@ti.com>
Message-ID: <20111006195842.GP6324@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Balaji T K <balajitk@ti.com> [111003 04:48]:
> MMC1 pbias and speed control fix for SDMMC1 extended I/O cell
> Rebase to git://github.com/tmlind/linux.git fixes
> 	commit 122a98589349fe3388ffb7b996b54614951c934a
> 	Author: Tapani Utriainen <tapani@technexion.com>
> 	Date:   Fri Sep 30 11:05:56 2011 -0700
> 
> 	    ARM: OMAP: irq: loop counter fix in omap_init_irq()
> 
> 
> Balaji T K (2):
>   arm: omap4: hsmmc: Fix Pbias configuration on regulator OFF
>   arm: omap4: hsmmc: configure SDMMC1_DR0 properly

Thanks adding both to fixes-part2 branch.

Regards,

Tony
