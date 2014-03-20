From: pratyush.anand@st.com (Pratyush Anand)
Date: Thu, 20 Mar 2014 14:27:17 +0530
Subject: [PATCH 4/4] ata: add new-style AHCI platform driver for ST
 SPEAr1340 AHCI controller
In-Reply-To: <1395081118-15248-5-git-send-email-b.zolnierkie@samsung.com>
References: <1395081118-15248-1-git-send-email-b.zolnierkie@samsung.com>
 <1395081118-15248-5-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <20140320085717.GC4607@pratyush-vbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 18, 2014 at 02:31:58AM +0800, Bartlomiej Zolnierkiewicz wrote:
> The new driver is named ahci_spear1340 and is only compile tested.  Once
> it is tested on the real hardware and verified to work correctly, the legacy
> platform code (which depends on the deprecated struct ahci_platform_data)
> can be removed.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

This patch will not be needed any more, since SPEAr sata platform code has
already been cleaned up.

See:
https://lkml.org/lkml/2014/2/28/174

Regards
Pratyush
