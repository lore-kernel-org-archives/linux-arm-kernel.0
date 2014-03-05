From: marex@denx.de (Marek Vasut)
Date: Wed, 5 Mar 2014 20:23:40 +0100
Subject: [PATCH] ahci_imx: Put #ifdef CONFIG_PM_SLEEP around suspend /
 resume functions
In-Reply-To: <1394047069-29902-1-git-send-email-hdegoede@redhat.com>
References: <1394047069-29902-1-git-send-email-hdegoede@redhat.com>
Message-ID: <201403052023.40492.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, March 05, 2014 at 08:17:49 PM, Hans de Goede wrote:
> This fixes the following warnings when CONFIG_PM_SLEEP is not set:
> 
> drivers/ata/ahci_imx.c:284:12: warning: ?imx_ahci_suspend? defined but not
> used [-Wunused-function] drivers/ata/ahci_imx.c:299:12: warning:
> ?imx_ahci_resume? defined but not used [-Wunused-function]
> 
> Reported-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Obviously makes sense.

Acked-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
