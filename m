From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Thu, 20 Mar 2014 12:51:32 +0100
Subject: [PATCH 4/4] ata: add new-style AHCI platform driver for ST
 SPEAr1340 AHCI controller
In-Reply-To: <20140320085717.GC4607@pratyush-vbox>
References: <1395081118-15248-1-git-send-email-b.zolnierkie@samsung.com>
 <1395081118-15248-5-git-send-email-b.zolnierkie@samsung.com>
 <20140320085717.GC4607@pratyush-vbox>
Message-ID: <3482323.3pWPcG8rCe@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Thursday, March 20, 2014 02:27:17 PM Pratyush Anand wrote:
> On Tue, Mar 18, 2014 at 02:31:58AM +0800, Bartlomiej Zolnierkiewicz wrote:
> > The new driver is named ahci_spear1340 and is only compile tested.  Once
> > it is tested on the real hardware and verified to work correctly, the legacy
> > platform code (which depends on the deprecated struct ahci_platform_data)
> > can be removed.
> > 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> 
> This patch will not be needed any more, since SPEAr sata platform code has
> already been cleaned up.
> 
> See:
> https://lkml.org/lkml/2014/2/28/174

OK.  Conversion of SPEAr1340 AHCI platform code to PHY driver is even better
than adding custom AHCI driver.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
