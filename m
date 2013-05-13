From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Mon, 13 May 2013 10:15:08 +0300
Subject: [PATCH] mtd: devices: added the 16mb winbond device
In-Reply-To: <516d0c68.e10b420a.287d.ffff894c@mx.google.com>
References: <516d0c68.e10b420a.287d.ffff894c@mx.google.com>
Message-ID: <1368429308.5360.6.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-04-16 at 14:01 +0530, girishks2000 at gmail.com wrote:
> From: Girish K S <ks.giri@samsung.com>
> 
> added a 16mb winbond devce to the device list
> erase size = 64k and number of blocks = 256
> 
> Signed-off-by: Girish K S <ks.giri@samsung.com>

Pushed to l2-mtd.git, but please, remember to use better suffixes. E.g.,
mb may mean mega bytes, or mega bits. 16MiB device, 64KiB block size is
a lot less ambiguous way communicate the sizes.

I've amended your commit message.

-- 
Best Regards,
Artem Bityutskiy
