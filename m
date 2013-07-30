From: nm@ti.com (Nishanth Menon)
Date: Tue, 30 Jul 2013 15:19:35 -0500
Subject: [PATCHv4 29/33] CLK: omap: add omap3 clock init file
In-Reply-To: <1374564028-11352-30-git-send-email-t-kristo@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
 <1374564028-11352-30-git-send-email-t-kristo@ti.com>
Message-ID: <51F81FD7.2060707@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/23/2013 02:20 AM, Tero Kristo wrote:
> clk-3xxx.c now contains the clock init functionality for omap3, including
> DT clock registration and adding of static clkdev entries.
>
> This patch also splits the OMAP3 clock registration code under mach-omap2
> to use OMAP3 subtype specific clk init functions.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>   arch/arm/mach-omap2/Makefile          |    2 +-
>   arch/arm/mach-omap2/cclock3xxx_data.c | 3641 ---------------------------------

Tony and a lot of people is not going to like removing support for 
non-dt boot for OMAP3 before "it's time is due" ;)



-- 
Regards,
Nishanth Menon
