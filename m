From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Wed, 05 Mar 2014 23:27:45 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gYWhjaV9pbXg6IFB1dCAjaWZkZWYgQ09ORklHX1BNX1NM?=
 =?UTF-8?B?RUVQIGFyb3VuZCBzdXNwZW5kIC8gcmVzdW1lIGZ1bmN0aW9ucw==?=
In-Reply-To: <201403052023.40492.marex@denx.de>
References: <1394047069-29902-1-git-send-email-hdegoede@redhat.com>
 <201403052023.40492.marex@denx.de>
Message-ID: <1394047665.191935701@f319.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?????,  5 ????? 2014, 20:23 +01:00 ?? Marek Vasut <marex@denx.de>:
> On Wednesday, March 05, 2014 at 08:17:49 PM, Hans de Goede wrote:
> > This fixes the following warnings when CONFIG_PM_SLEEP is not set:
> > 
> > drivers/ata/ahci_imx.c:284:12: warning: ?imx_ahci_suspend? defined but not
> > used [-Wunused-function] drivers/ata/ahci_imx.c:299:12: warning:
> > ?imx_ahci_resume? defined but not used [-Wunused-function]
> > 
> > Reported-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Obviously makes sense.
> 
> Acked-by: Marek Vasut <marex@denx.de>

But a better way is to use the "__maybe_unused" attribute for such cases.

---
