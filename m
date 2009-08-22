From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 22 Aug 2009 02:23:50 +0200
Subject: [PATCH] Convert MMC subsys drivers to dev_pm_ops
Message-ID: <200908220223.50588.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This converts most of the drivers found in drivers/mmc/host to dev_pm_ops.
Also, it contains some fixes for the probe/remove functions in some cases.

This needs testing, so I'd be very glad if the affected maintainers expressed 
their opinion on this.

Cheers!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-Convert-MMC-subsys-drivers-to-dev_pm_ops.patch
Type: text/x-patch
Size: 30733 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20090822/485a29cf/attachment-0001.bin>
