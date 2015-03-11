From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Mar 2015 15:37:34 +0100
Subject: [PATCH][RESEND] ARM: vexpress: update CONFIG_USB_ISP1760 option
In-Reply-To: <1425925669-8561-1-git-send-email-sudeep.holla@arm.com>
References: <1425925669-8561-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <2270067.EVeXEFvz96@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 09 March 2015 18:27:49 Sudeep Holla wrote:
> Commit 7ef077a8ad35 ("usb: isp1760: Move driver from drivers/usb/host/
> to drivers/usb/isp1760/") moved the isp1760 driver and changed the
> Kconfig option. This makes CONFIG_USB_ISP1760_HCD not selectable
> directly anymore. This results in driver being not compiled in when
> using vexpress_defconfig and the USB is non-functional.
> 
> This patch updates the CONFIG_USB_ISP1760_HCD to CONFIG_USB_ISP1760 to
> get back USB functional on vexpress platforms.
> 

Pulled into fixes, thanks!

	Arnd
