From: HartleyS@visionengravers.com (Hartley Sweeten)
Date: Thu, 17 Oct 2013 18:30:16 +0000
Subject: [PATCH v2] usb: ohci: remove ep93xx bus glue platform driver
In-Reply-To: <Pine.LNX.4.44L0.1310161711310.1264-100000@iolanthe.rowland.org>
References: <525EFD0B.2020607@gmail.com>
 <Pine.LNX.4.44L0.1310161711310.1264-100000@iolanthe.rowland.org>
Message-ID: <DC148C5AA1CEBA4E87973D432B1C2D8817DB3A7A@P3PWEX4MB008.ex4.secureserver.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, October 16, 2013 2:13 PM, Alan Stern wrote:
> Sure, that's what I meant.  All that churn was caused by re-minimizing
> the defconfig file, not by adding USB_OHCI_HCD_PLATFORM.

As requested, I have split this patch to:
1) refresh the ep93xx_defconfig
2) remove the ep93xx bus glue driver

I just posted the new patch series as v3.

If there are any other issues I will happily fix them.

> Greg KH and I can take both patches.

Thanks,
Hartley
