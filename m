From: tony@atomide.com (Tony Lindgren)
Date: Thu, 3 Oct 2013 11:00:43 -0700
Subject: [PATCH] ARM: OMAP2: gpmc-onenand: fix sync mode setup with DT
In-Reply-To: <20131001213318.GA29989@blackmetal.musicnaut.iki.fi>
References: <1379707266-2301-1-git-send-email-aaro.koskinen@iki.fi>
 <20131001213318.GA29989@blackmetal.musicnaut.iki.fi>
Message-ID: <20131003180043.GN8949@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [131001 14:41]:
> Hi,
> 
> Any comments about the below patch? If my analysis is correct, this issue
> needs to be fixed before any boards that set ONENAND_SYNC_READWRITE can
> be converted to DT. So the fix should be applied preferably during the
> current rc-cycle.

Thanks I'll apply it into omap-for-v3.12/fixes.

Regards,

Tony
