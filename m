From: jeff@garzik.org (Jeff Garzik)
Date: Wed, 14 Jul 2010 03:51:32 -0400
Subject: [PATCH v7] libata: pata_samsung: Add Samsung PATA controller
	driver
In-Reply-To: <1278994985-15748-1-git-send-email-kgene.kim@samsung.com>
References: <1278994985-15748-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <4C3D6C84.5020403@garzik.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/13/2010 12:23 AM, Kukjin Kim wrote:
> From: Abhilash Kesavan<a.kesavan@samsung.com>
>
> Adds support for the Samsung PATA controller. This driver is based on the
> Libata subsystem and references the earlier patches sent for IDE subsystem.
>
> Signed-off-by: Abhilash Kesavan<a.kesavan@samsung.com>
> Signed-off-by: Kukjin Kim<kgene.kim@samsung.com>
> Cc: Ben Dooks<ben-linux@fluff.org>
> Acked-by: Sergei Shtylyov<sshtylyov@mvista.com>
> ---
> Changes since v6:
> - Removed check for device 1 in pata_s3c_wait_after_reset() and
>    associated changes
> - Initialized directly in pata_s3c_remove() and pata_s3c_resume()
>
>   drivers/ata/Kconfig           |    9 +
>   drivers/ata/Makefile          |    1 +
>   drivers/ata/pata_samsung_cf.c |  683 +++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 693 insertions(+), 0 deletions(-)
>   create mode 100644 drivers/ata/pata_samsung_cf.c

applied
