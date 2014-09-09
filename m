From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 09 Sep 2014 22:22:54 +0200
Subject: [PATCH v2 1/2] PCI: keystone: remove handle of PCI mode
 configuration
In-Reply-To: <1410293835-13050-1-git-send-email-m-karicheri2@ti.com>
References: <1410293835-13050-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <2873880.LROUF1qxur@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 September 2014 16:17:14 Murali Karicheri wrote:
> Keystone PCI hardware supports both RC and EP modes and devcfg
> register has bits to boot strap the device to either of these modes.
> It seems proper to add this functionality to the boot loader rather
> than in the driver as device will be operating in either mode, not
> both any time. Currently the driver supports only RC mode and hence
> register configuration in the driver is not needed and driver can
> assume this is a RC hardware.
> 
> Also update the DT documentation accordingly.
> 
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> 

Thanks for doing this,

Acked-by: Arnd Bergmann <arnd@arndb.de>
