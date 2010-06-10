From: jgarzik@pobox.com (Jeff Garzik)
Date: Thu, 10 Jun 2010 04:52:07 -0400
Subject: [PATCH v3] libata: pata_samsung_cf: Add Samsung PATA controller
	driver
In-Reply-To: <1276156241-28804-1-git-send-email-kgene.kim@samsung.com>
References: <1276156241-28804-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <4C10A7B7.4090601@pobox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10/2010 03:50 AM, Kukjin Kim wrote:
> From: Abhilash Kesavan<a.kesavan@samsung.com>
>
> Adds support for the Samsung PATA controller. This driver is based on the
> Libata subsystem and references the earlier patches sent for IDE subsystem.
>
> Signed-off-by: Abhilash Kesavan<a.kesavan@samsung.com>
> Signed-off-by: Kukjin Kim<kgene.kim@samsung.com>
> ---
>
> Changes since v2:
> - Changed the DRV_NAME to pata_samsung_cf
> - Used msleep instead of mdelay
>
>   drivers/ata/Makefile          |    1 +
>   drivers/ata/pata_samsung_cf.c |  608 +++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 618 insertions(+), 0 deletions(-)
>   create mode 100644 drivers/ata/pata_samsung_cf.c

Acked-by: Jeff Garzik <jgarzik@redhat.com>


I presume you'll send this upstream via the appropriate ARM tree.
