From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Wed, 22 Mar 2017 18:49:12 +0100
Subject: [PATCH v2 1/3] ata: add Palmchip BK3710 PATA controller driver
In-Reply-To: <8fc9171f-15b7-2c6a-d0b5-3af21cc88405@ti.com>
References: <1489509414-11491-1-git-send-email-b.zolnierkie@samsung.com>
 <1489509414-11491-2-git-send-email-b.zolnierkie@samsung.com>
 <8fc9171f-15b7-2c6a-d0b5-3af21cc88405@ti.com>
 <CGME20170322174917epcas1p1a4ba3e4da231ee3b7784cb0c669611ed@epcas1p1.samsung.com>
Message-ID: <1819267.Nm9hpTOhuY@amdc3058>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Tuesday, March 21, 2017 02:04:38 PM Sekhar Nori wrote:
> Hi,
> 
> On Tuesday 14 March 2017 10:06 PM, Bartlomiej Zolnierkiewicz wrote:
> > Add Palmchip BK3710 PATA controller driver.
> > 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> 
> There are some checkpatch suggestions that are worth fixing, I think.
> 
> [PATCH v2 1_3] ata: add Palmchip BK3710 PATA controller driver - Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> - 2017-03-14 2206.eml:277: CHECK: Alignment should match open parenthesis
> [PATCH v2 1_3] ata: add Palmchip BK3710 PATA controller driver - Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> - 2017-03-14 2206.eml:320: CHECK: Alignment should match open parenthesis
> [PATCH v2 1_3] ata: add Palmchip BK3710 PATA controller driver - Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> - 2017-03-14 2206.eml:489: CHECK: Comparison to NULL could be written "!mem"

Will be fixed in v3, thanks.

[ My scripts didn't run checkpatch with --strict so I haven't noticed them. ]

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
