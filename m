From: arend.vanspriel@broadcom.com (Arend Van Spriel)
Date: Thu, 15 Dec 2016 21:15:23 +0100
Subject: [PATCH 8/8] Makefile: drop -D__CHECK_ENDIAN__ from cflags
In-Reply-To: <1481778865-27667-9-git-send-email-mst@redhat.com>
References: <1481778865-27667-1-git-send-email-mst@redhat.com>
 <1481778865-27667-9-git-send-email-mst@redhat.com>
Message-ID: <5186291e-90ed-3070-72ad-d6f78fd1a410@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15-12-2016 6:15, Michael S. Tsirkin wrote:
> That's the default now, no need for makefiles to set it.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/bluetooth/Makefile                                | 2 --
>  drivers/net/can/Makefile                                  | 1 -
>  drivers/net/ethernet/altera/Makefile                      | 1 -
>  drivers/net/ethernet/atheros/alx/Makefile                 | 1 -
>  drivers/net/ethernet/freescale/Makefile                   | 2 --
>  drivers/net/wireless/ath/Makefile                         | 2 --
>  drivers/net/wireless/ath/wil6210/Makefile                 | 2 --
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/Makefile | 2 --
>  drivers/net/wireless/broadcom/brcm80211/brcmsmac/Makefile | 1 -

For brcm80211 drivers:

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Regards,
Arend
