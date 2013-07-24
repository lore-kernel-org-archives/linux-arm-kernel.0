From: rogerq@ti.com (Roger Quadros)
Date: Wed, 24 Jul 2013 17:16:52 +0300
Subject: [PATCHv4 00/33] ARM: OMAP: clock conversion to DT
In-Reply-To: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
Message-ID: <51EFE1D4.8090307@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/23/2013 10:19 AM, Tero Kristo wrote:
> Hi,
> 
> Changes compared to previous version:
> 
> - Clock init files moved from mach-omap2/ to drivers/clk/omap/
> - AM33xx support added [patches 15-20]
> - OMAP3 support added [patches 21-29]
> - DRA7 APLL support added (thanks Keerthy) [patches 30-33]
> 
> Test branch on top of 3.11-rc1 available here:
> 
> git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
> branch: mainline-3.11-rc1-omap-dt-clks
> 
> Testing done:
> 
> - boot + suspend tested on OMAP3 beagle C4 (omap3530)
> - boot + suspend tested on OMAP4 panda ES (omap4460)
> - boot tested on beagle bone (am335x)
> 
> A boot test was also executed for DRA7 and OMAP5 on a separate branch
> (mainline does not have OMAP5 / DRA7 support so far.)

Thanks to your hints, I was able to get this to work with 3.11-rc1 on omap5 uevm
using the following 3 patches. Please include them in your series. Thanks.

cheers,
-roger
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ARM-dts-OMAP5-Provide-clock-tree-data.patch
Type: text/x-patch
Size: 802 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130724/2dbc50ae/attachment-0003.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-CLK-omap5-Call-clock-init-function-at-boot.patch
Type: text/x-patch
Size: 1311 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130724/2dbc50ae/attachment-0004.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0003-CLK-omap5-Initialize-USB_DPLL-at-boot.patch
Type: text/x-patch
Size: 1552 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130724/2dbc50ae/attachment-0005.bin>
