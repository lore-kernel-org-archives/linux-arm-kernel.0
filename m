From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 21 Mar 2017 14:04:38 +0530
Subject: [PATCH v2 1/3] ata: add Palmchip BK3710 PATA controller driver
In-Reply-To: <1489509414-11491-2-git-send-email-b.zolnierkie@samsung.com>
References: <1489509414-11491-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20170314163742epcas5p32a49df6b4ae6c21ee159c79320df5781@epcas5p3.samsung.com>
 <1489509414-11491-2-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <8fc9171f-15b7-2c6a-d0b5-3af21cc88405@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tuesday 14 March 2017 10:06 PM, Bartlomiej Zolnierkiewicz wrote:
> Add Palmchip BK3710 PATA controller driver.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

There are some checkpatch suggestions that are worth fixing, I think.

[PATCH v2 1_3] ata: add Palmchip BK3710 PATA controller driver - Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> - 2017-03-14 2206.eml:277: CHECK: Alignment should match open parenthesis
[PATCH v2 1_3] ata: add Palmchip BK3710 PATA controller driver - Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> - 2017-03-14 2206.eml:320: CHECK: Alignment should match open parenthesis
[PATCH v2 1_3] ata: add Palmchip BK3710 PATA controller driver - Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> - 2017-03-14 2206.eml:489: CHECK: Comparison to NULL could be written "!mem"

Thanks,
Sekhar
