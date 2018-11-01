From: jagan@amarulasolutions.com (Jagan Teki)
Date: Thu, 1 Nov 2018 13:05:08 +0530
Subject: [RFC PATCH 7/7] arm64: allwinner: h6: orangepi-liet2: Enable
 AP6356S WiFi support
In-Reply-To: <20181031183634.29640-7-jagan@amarulasolutions.com>
References: <20181031183634.29640-1-jagan@amarulasolutions.com>
 <20181031183634.29640-7-jagan@amarulasolutions.com>
Message-ID: <CAMty3ZCeZzXYy4XRwTeQjYfpB6KKjEVRWyhjoca9Os4foLYL4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 1, 2018 at 12:07 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> From: Jagan Teki <jagan@openedev.com>
>
> Enable AP6356S WiFi/BT combo chip on Orangepi Lite2 board:
> - WiFi SDIO interface is connected to MMC1
> - WiFi WL-PMU-EN pin connected to gpio PM3: attach to mmc-pwrseq
> - WiFi WL-WAKE-AP pin connected to gpio PM0
> - 32kHz external oscillator gate clock from RTC
>
> Signed-off-by: Jagan Teki <jagan@openedev.com>
> ---
> Note:
> - chip detected, but failed to connect
> [  129.084504] brcmfmac: brcmf_sdio_hostmail: mailbox indicates firmware halted
> [  135.906409] brcmfmac: brcmf_sdio_bus_rxctl: resumed on timeout

This got fixed. Will send next version.
