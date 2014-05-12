From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 May 2014 14:32:35 +0200
Subject: [PATCH v13 2/2] ARM: sunxi: Add driver for SD/MMC hosts found on
 Allwinner sunxi SoCs
In-Reply-To: <1399896288-5826-3-git-send-email-hdegoede@redhat.com>
References: <1399896288-5826-1-git-send-email-hdegoede@redhat.com>
 <1399896288-5826-3-git-send-email-hdegoede@redhat.com>
Message-ID: <4897597.kB99FVQvx0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 12 May 2014 14:04:48 Hans de Goede wrote:
> From: David Lanzend?rfer <david.lanzendoerfer@o2s.ch>
> 
> The Allwinner sunxi mmc host uses dma in bus-master mode using a built-in
> designware idmac controller, which is identical to the one found in the mmc-dw
> hosts. However the rest of the host is not identical to mmc-dw, it deals with
> sending stop commands in hardware which makes it significantly different
> from the mmc-dw devices.
> 
> HdG: Various cleanups and fixes.
> 
> Signed-off-by: David Lanzend?rfer <david.lanzendoerfer@o2s.ch>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
