From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 23 Mar 2017 19:27:05 +0530
Subject: [PATCH v3 0/5] ATA/ARM: convert ARM/DaVinci to use libata PATA
 drivers
In-Reply-To: <1490206862-26065-1-git-send-email-b.zolnierkie@samsung.com>
References: <CGME20170322182127epcas1p267b13e8c92205223458863783bdea476@epcas1p2.samsung.com>
 <1490206862-26065-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <aaf669ba-4439-9af7-7943-c9163bd99020@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 22 March 2017 11:50 PM, Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> This patchset adds Palmchip BK3710 IDE controller driver to
> libata and switches ARM/DaVinci to use it (instead of the old
> IDE driver).
> 
> Sekhar, please check that it still works after changes, thanks.

Did some basic mount/read/write tests, it passed.

Thanks,
Sekhar
