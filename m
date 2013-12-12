From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 12 Dec 2013 16:03:28 -0500
Subject: [PATCH v3 0/3] ARM: dts: Keystone II USB nodes
In-Reply-To: <1386628333-1849-1-git-send-email-w-kwok2@ti.com>
References: <1386628333-1849-1-git-send-email-w-kwok2@ti.com>
Message-ID: <52AA24A0.3070208@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 09 December 2013 05:32 PM, WingMan Kwok wrote:
> Here is the separated dts series which addresses comments from
> earlier version [1].
> 
> Series adds USB host dts nodes for Keystone SOCs. Keystone SOCs uses dwc3
> hardware IP implementation. We use no-op phy driver.
> 
> Patchset are tested on Keystone II EVM with USB2.0 and USB3.0 flash drives.
> 
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> WingMan Kwok (3):
>   ARM: dts: keystone: Add usb phy devicetree bindings
>   ARM: dts: keystone: Add usb devicetree bindings
>   ARM: keystone: defconfig: enable USB support
> 
The USB driver is merged toward 3.14 now so I will take these in
my 3.14 queue.

Thanks for the patches.

Regards,
Santosh
