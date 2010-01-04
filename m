From: svenkatr@ti.com (Venkatraman S)
Date: Mon, 4 Jan 2010 12:33:11 +0530
Subject: [Patch v4] OMAP: sDMA driver: descriptor autoloading feature
In-Reply-To: <20091228214846.GP3512@atomide.com>
References: <618f0c910912110701p771dcf6fg655bb0a7b9bdc96d@mail.gmail.com>
	<20091228214846.GP3512@atomide.com>
Message-ID: <618f0c911001032303p5d103f3et6271a71e1e5fbc96@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 29, 2009 at 3:18 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Venkatraman S <svenkatr@ti.com> [091211 07:01]:
>> Here is the most updated version of the patch (thanks to Russell's
>> review). This patch is applicable to OMAP4xxx as well as OMAP3630
>> Reference to previous posts
>> v1 ?http://marc.info/?l=linux-omap&m=125012097403050&w=2
>> v2 ?http://marc.info/?l=linux-omap&m=125137152606644&w=2
>> v3 ?http://patchwork.kernel.org/patch/45408/
>
> Do you have a patch for drivers/mmc/host/omap_hsmmc.c to
> use this feature? Or some other driver?
>
> Regards,
>
> Tony

I am about to start working on omap_hsmmc to use the descriptor load
feature. If the DMA changes are acceptable, I can post the driver
patch as well.

Best regards,

Venkat.
