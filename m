From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 15 Dec 2016 03:50:59 -0800
Subject: [PATCH 8/8] Makefile: drop -D__CHECK_ENDIAN__ from cflags
In-Reply-To: <1481778865-27667-9-git-send-email-mst@redhat.com>
References: <1481778865-27667-1-git-send-email-mst@redhat.com>
 <1481778865-27667-9-git-send-email-mst@redhat.com>
Message-ID: <20161215115059.GA22750@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 15, 2016 at 07:15:30AM +0200, Michael S. Tsirkin wrote:
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
>  drivers/net/wireless/intersil/orinoco/Makefile            | 3 ---
>  drivers/net/wireless/mediatek/mt7601u/Makefile            | 2 --
>  drivers/net/wireless/realtek/rtlwifi/Makefile             | 2 --
>  drivers/net/wireless/realtek/rtlwifi/btcoexist/Makefile   | 2 --
>  drivers/net/wireless/realtek/rtlwifi/rtl8188ee/Makefile   | 2 --
>  drivers/net/wireless/realtek/rtlwifi/rtl8192c/Makefile    | 2 --
>  drivers/net/wireless/realtek/rtlwifi/rtl8192ce/Makefile   | 2 --
>  drivers/net/wireless/realtek/rtlwifi/rtl8192cu/Makefile   | 2 --
>  drivers/net/wireless/realtek/rtlwifi/rtl8192de/Makefile   | 2 --
>  drivers/net/wireless/realtek/rtlwifi/rtl8192ee/Makefile   | 2 --
>  drivers/net/wireless/realtek/rtlwifi/rtl8192se/Makefile   | 2 --
>  drivers/net/wireless/realtek/rtlwifi/rtl8723ae/Makefile   | 2 --
>  drivers/net/wireless/realtek/rtlwifi/rtl8723be/Makefile   | 2 --
>  drivers/net/wireless/realtek/rtlwifi/rtl8723com/Makefile  | 2 --
>  drivers/net/wireless/realtek/rtlwifi/rtl8821ae/Makefile   | 2 --
>  drivers/net/wireless/ti/wl1251/Makefile                   | 2 --
>  drivers/net/wireless/ti/wlcore/Makefile                   | 2 --
>  drivers/staging/rtl8188eu/Makefile                        | 2 +-
>  drivers/staging/rtl8192e/Makefile                         | 2 --
>  drivers/staging/rtl8192e/rtl8192e/Makefile                | 2 --
>  net/bluetooth/Makefile                                    | 2 --
>  net/ieee802154/Makefile                                   | 2 --
>  net/mac80211/Makefile                                     | 2 +-
>  net/mac802154/Makefile                                    | 2 --
>  net/wireless/Makefile                                     | 2 --
>  38 files changed, 5 insertions(+), 68 deletions(-)

For drivers/staging:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
