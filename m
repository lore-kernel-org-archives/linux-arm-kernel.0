From: luca@coelho.fi (Luca Coelho)
Date: Mon, 19 Dec 2016 11:08:10 +0200
Subject: [PATCH 8/8] Makefile: drop -D__CHECK_ENDIAN__ from cflags
In-Reply-To: <1481778865-27667-9-git-send-email-mst@redhat.com>
References: <1481778865-27667-1-git-send-email-mst@redhat.com>
 <1481778865-27667-9-git-send-email-mst@redhat.com>
Message-ID: <1482138490.26174.7.camel@coelho.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-12-15 at 07:15 +0200, Michael S. Tsirkin wrote:
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
>  drivers/net/wireless/intel/iwlegacy/Makefile              | 2 --
>  drivers/net/wireless/intel/iwlwifi/Makefile               | 2 +-
>  drivers/net/wireless/intel/iwlwifi/dvm/Makefile           | 2 +-
>  drivers/net/wireless/intel/iwlwifi/mvm/Makefile           | 2 +-

For the drivers/net/wireless/intel/iwlwifi/ part:

Acked-by: Luca Coelho <luciano.coelho@intel.com>

--
Luca.
