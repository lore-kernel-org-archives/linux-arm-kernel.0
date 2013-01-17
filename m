From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Thu, 17 Jan 2013 14:30:53 +0200
Subject: [PATCH v2] mtd: vt8500: Add support for Wondermedia Serial
 Flash Controller
In-Reply-To: <1358421664.2731.228.camel@sauron.fi.intel.com>
References: <1358272414-6266-1-git-send-email-linux@prisktech.co.nz>
 <1358421664.2731.228.camel@sauron.fi.intel.com>
Message-ID: <1358425853.2731.241.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-01-17 at 13:21 +0200, Artem Bityutskiy wrote:
> Probably this should also be outside of the driver, since it is not
> specific to this driver.

Take a look at this huge array which constantly gets updated with new
chips (see git log):

drivers/mtd/devices/m25p80.c
static const struct spi_device_id m25p_ids[]

I think this should be generalized and shared across the drivers.

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130117/37bfec93/attachment.sig>
