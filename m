From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Fri, 4 Nov 2011 15:34:15 +0100
Subject: [PATCH 0/2] mmc: mmci: Bugfixes for SDIO
In-Reply-To: <1319464243-16638-1-git-send-email-ulf.hansson@stericsson.com>
References: <1319464243-16638-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <4EB3F7E7.1070901@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Is this patch and it's patchserie considered OK?

-Russell, patches are available in your patchtracker.

Br
Ulf Hansson

Ulf HANSSON wrote:
> This patchserie fixes some SDIO related issues for the mmci host driver.
> 
> Previously these patches were included in the patch serie called
> "mmc: mmci: Improvements and bugfixes for SDIO", which now has been
> split up.
> 
> Stefan Nilsson XK (1):
>   mmc: mmci: Fix incorrect handling of HW flow control for SDIO
> 
> Ulf Hansson (1):
>   mmc: mmci: Prepare for SDIO before setting up DMA job
> 
>  drivers/mmc/host/mmci.c |   50 ++++++++++++++++++++++++++--------------------
>  1 files changed, 28 insertions(+), 22 deletions(-)
> 
