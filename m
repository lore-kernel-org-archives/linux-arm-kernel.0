From: tony@atomide.com (Tony Lindgren)
Date: Fri, 10 Jun 2016 02:34:00 -0700
Subject: [PATCH 0/3] ARM: OMAP: DRA7: Update to latest TRM and cleanup
In-Reply-To: <1464096940-27145-1-git-send-email-nm@ti.com>
References: <1464096940-27145-1-git-send-email-nm@ti.com>
Message-ID: <20160610093359.GQ22406@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Nishanth Menon <nm@ti.com> [160524 06:37]:
> Hi,
> 
> Here are the final(hopefully) pending patches for DRA7 based on recent
> TRM updates. Updates include removing retention support on L3init and
> L4per as per latest SoC updates.
> 
> Test Log: X15 (no modules): http://pastebin.ubuntu.com/16655027/
> 
> Latest TRM (rev F): http://www.ti.com/lit/pdf/spruhz6 (public on May 18)
> 
> Nishanth Menon (3):
>   ARM: OMAP: DRA7: powerdomain data: Set L3init and L4per to ON
>   ARM: OMAP: DRA7: powerdomain data: Remove unused pwrsts_logic_ret
>   ARM: OMAP: DRA7: powerdomain data: Remove unused pwrsts_mem_ret
> 
>  arch/arm/mach-omap2/powerdomains7xx_data.c | 76 +-----------------------------
>  1 file changed, 2 insertions(+), 74 deletions(-)

Can these wait until v4.8 merge window, are this needed as fixes to
avoid hardware problems?

Regards,

Tony
