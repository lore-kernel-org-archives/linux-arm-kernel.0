From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 2 Dec 2014 11:10:53 +0100
Subject: [PATCH v4 0/4] mmc: atmel-mci: cleanup and probe deferring
In-Reply-To: <1417444509-15501-1-git-send-email-ludovic.desroches@atmel.com>
References: <1417444509-15501-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <CAPDyKFpuDOfw9BtYJhG0Fz6PsqUQP=gBg+4mWt9MRy_S6Yga5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 December 2014 at 15:35, Ludovic Desroches
<ludovic.desroches@atmel.com> wrote:
> Hi Ulf,
>
> Same as previous series, based on your next branch, and no errors with
> checkpatch so let me know if you still have troubles to apply my patches.
>
> Changes from v3:
> - keep __init/__exit attributes for atmci_init/exit
> - remove useless variable in atmci_configure_dma function
>
> Ludovic Desroches (4):
>   mmc: atmel-mci: remove useless DMA stuff for non-dt devices
>   mmc: atmel-mci: remove __init/__exit attributes
>   mmc: atmel-mci: stop using specific initcall
>   mmc: atmel-mci: use probe deferring if dma controller is not ready yet
>
>  drivers/mmc/host/atmel-mci.c | 76 ++++++++++++++++----------------------------
>  1 file changed, 28 insertions(+), 48 deletions(-)

Thanks! Applied for next.

Patch 4, did have a minor checkpatch warning. I fixed it.

Kind regards
Uffe
