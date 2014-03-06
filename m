From: tj@kernel.org (Tejun Heo)
Date: Thu, 6 Mar 2014 14:31:54 -0500
Subject: [PATCH] ahci_imx: Put #ifdef CONFIG_PM_SLEEP around suspend /
 resume functions
In-Reply-To: <1394047069-29902-1-git-send-email-hdegoede@redhat.com>
References: <1394047069-29902-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20140306193154.GC14033@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 05, 2014 at 08:17:49PM +0100, Hans de Goede wrote:
> This fixes the following warnings when CONFIG_PM_SLEEP is not set:
> 
> drivers/ata/ahci_imx.c:284:12: warning: ?imx_ahci_suspend? defined but not used [-Wunused-function]
> drivers/ata/ahci_imx.c:299:12: warning: ?imx_ahci_resume? defined but not used [-Wunused-function]
> 
> Reported-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied to libata/for-3.15.

Thanks.

-- 
tejun
