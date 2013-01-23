From: linux@prisktech.co.nz (Tony Prisk)
Date: Thu, 24 Jan 2013 07:28:50 +1300
Subject: [PATCH v3 1/2] mtd: Add a common JEDEC flash device table
In-Reply-To: <50FFA692.2060907@parrot.com>
References: <1358928068-12417-1-git-send-email-linux@prisktech.co.nz>
 <1358928068-12417-2-git-send-email-linux@prisktech.co.nz>
 <50FFA692.2060907@parrot.com>
Message-ID: <1358965730.13715.0.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-01-23 at 10:00 +0100, Matthieu CASTET wrote:
> Tony Prisk a ?crit :
> > This patch adds a common JEDEC flash device table which can be
> > expanded on as more features are required.
> > 
> > A simple match function is also included to query the table for
> > a match based on the JEDEC id.
> 
> Why don't you use id from include/linux/mtd/cfi.h that is used by flash driver
> like drivers/mtd/devices/m25p80.c ?
> 

Thanks - have changed for v4.

Regards
Tony P
