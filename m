From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Thu, 07 Jun 2012 15:45:59 +0300
Subject: 
In-Reply-To: <20120607101124.GH30400@pengutronix.de>
References: <1338978796-26129-1-git-send-email-s.hauer@pengutronix.de>
 <1338993547.6875.65.camel@sauron.fi.intel.com>
 <20120607101124.GH30400@pengutronix.de>
Message-ID: <1339073159.6875.101.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-06-07 at 12:11 +0200, Sascha Hauer wrote:
> Fixing these warnings in the nand driver does not seem to be the correct
> approach. Initializing mxc_nand_devtype_data as const seems sane, the
> problem is that struct of_device_id expects a void * instead of a const
> void *. A patch fixing this is outstanding here:
> 
> http://permalink.gmane.org/gmane.linux.drivers.devicetree/15069
> 
> (this will also fix the other sparse warnings from this driver)
> 
> I asked Uwe to resend this.

Pushed to l2-mtd.git, thanks!

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120607/33d785e7/attachment.sig>
