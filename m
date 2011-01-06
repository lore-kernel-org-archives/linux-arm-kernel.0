From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Thu, 6 Jan 2011 13:53:22 +0300
Subject: [PATCH v2 2/3] ahci_pltfm: switch to module device table matching
In-Reply-To: <1294206187-11487-3-git-send-email-mkl0301@gmail.com>
References: <1294206187-11487-1-git-send-email-mkl0301@gmail.com>
	<1294206187-11487-3-git-send-email-mkl0301@gmail.com>
Message-ID: <20110106105322.GA10102@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 05, 2011 at 01:43:06PM +0800, mkl0301 at gmail.com wrote:
> From: Mac Lin <mkl0301@gmail.com>
> 
> Switch the driver to use module device table matching mechanism to add SoC-specific parts to the generic driver.
> 
> Signed-off-by: Mac Lin <mkl0301@gmail.com>
> ---
>  drivers/ata/ahci_pltfm.c |   14 +++++++++++++-
>  drivers/ata/ahci_pltfm.h |   17 +++++++++++++++++
>  2 files changed, 30 insertions(+), 1 deletions(-)
>  create mode 100644 drivers/ata/ahci_pltfm.h
> 
[..]
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef _DRIVERS_SATA_AHCI_PLTFM_H
> +#define _DRIVERS_SATA_AHCI_PLTFM_H
> +
> +#endif /* _DRIVERS_SATA_AHCI_PLTFM_H */
> +
> --

No need for this empty line at the end of the file.

-- 
Anton Vorontsov
Email: cbouatmailru at gmail.com
