From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 20 Jan 2014 10:57:28 +0100
Subject: [RFC v3 08/13] ahci-platform: Allow specifying platform_data
 through of_device_id
In-Reply-To: <52DCE9A4.50901@redhat.com>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
 <1390088935-7193-9-git-send-email-hdegoede@redhat.com>
 <20140120082438.GH16215@pengutronix.de>
 <52DCDFBA.2070903@redhat.com>
 <20140120090950.GI16215@pengutronix.de> <52DCE9A4.50901@redhat.com>
Message-ID: <20140120095728.GM16215@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 20, 2014 at 10:17:24AM +0100, Hans de Goede wrote:
> Hi,
> 
> I'm currently working on a slightly different implementation of a more
> generic ahci_platform.c where ahci_platform.c exports some standard platform
> related functionality as library functions.
> 
> Drivers which need to override some of ahci_platform.c's behavior because of
> non standard hw, will then export their own struct platform_driver and can
> call into the exported functions for standard stuff to avoid code duplication
> where appropriate, while still having 100% freedom to do things in a custom
> way where necessary.

Nice, thanks.

> 
> I hope to post a PATCH RFC v4 with these changes later today, which you will
> hopefully like better. Input on v4, even just a "yep better" remark would be
> much appreciated.

Yes, I will give feedback on v4.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
