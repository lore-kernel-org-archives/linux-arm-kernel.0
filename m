From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 03 Sep 2012 17:42:34 +0200
Subject: [PATCH v2 0/9] Add device tree support for on-chip SRAM
In-Reply-To: <20120903015343.GB2362@S2101-09.ap.freescale.net>
References: <1346405224-20399-1-git-send-email-p.zabel@pengutronix.de>
 <20120903015343.GB2362@S2101-09.ap.freescale.net>
Message-ID: <1346686954.2391.13.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Am Montag, den 03.09.2012, 09:53 +0800 schrieb Shawn Guo:
> I do not understand the point of introducing those imx patches, 1 ~ 4
> and 7, 8.  They are all unnecessary churns to me.  IMO, 4 patches are
> enough.
> 
>  * genalloc: add a global pool list, allow to find pools by phys address
>  * misc: Generic on-chip SRAM allocation driver
>  * ARM i.MX: remove IRAM_ALLOC facility
>  * ARM: dts: add sram for imx53 and imx6q
> 
> Regards,
> Shawn

Thanks, I thought that first making the iram_alloc API work would
decouple this a bit from the coda vpu patches that depend on sram
support on imx53/6q. I'll work in your comments and reduce the patch
count as you propose.

regards
Philipp
