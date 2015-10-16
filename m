From: rjui@broadcom.com (Ray Jui)
Date: Fri, 16 Oct 2015 12:43:17 -0700
Subject: [PATCH] PCI: iproc: Fix company name
In-Reply-To: <1445022248-12203-1-git-send-email-f.fainelli@gmail.com>
References: <1445022248-12203-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <56215355.4070009@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/16/2015 12:04 PM, Florian Fainelli wrote:
> The header of pcie-iproc.c contains an obvious typo on Broadcom
> Corporation, fix that.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/pci/host/pcie-iproc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
> index fe2efb141a9b..6c3d4b54858c 100644
> --- a/drivers/pci/host/pcie-iproc.c
> +++ b/drivers/pci/host/pcie-iproc.c
> @@ -1,6 +1,6 @@
>  /*
>   * Copyright (C) 2014 Hauke Mehrtens <hauke@hauke-m.de>
> - * Copyright (C) 2015 Broadcom Corporatcommon ion
> + * Copyright (C) 2015 Broadcom Corporation
>   *
>   * This program is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU General Public License as
> 

When I saw the subject, for a while I thought you are going to change it
to Broadcom Limited, :)

Thanks for fixing this!

Acked-by: Ray Jui <rjui@broadcom.com>
