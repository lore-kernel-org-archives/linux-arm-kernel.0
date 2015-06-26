From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 26 Jun 2015 14:11:10 +0100
Subject: Support CONFIG_CMDLINE for arm64?
In-Reply-To: <2937668.KYNC73kFne@diego>
References: <CAErSpo4=11L8QPdeJRFrxR_E7sL+sg2T51TN8KcjmPQoo2Oy=g@mail.gmail.com>
 <2937668.KYNC73kFne@diego>
Message-ID: <20150626131109.GE3078@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 26, 2015 at 10:15:47AM +0200, Heiko St?bner wrote:
> Am Donnerstag, 25. Juni 2015, 17:02:41 schrieb Bjorn Helgaas:
> > arch/arm64/Kconfig mentions CONFIG_CMDLINE, but I don't see any actual
> > support for it.  Would you be interested in support for it?  Or would
> > you rather remove it from Kconfig?
> 
> just stumbled over your mail by chance.
> 
> CONFIG_CMDLINE is for example included in drivers/of/fdt.c, so will be handled 
> correctly for devicetree-based arm64 platforms - and I'm actually using it on 
> my rk3368 board :-) .

Indeed. The early_init_dt_scan_chosen() takes it into account.

-- 
Catalin
