From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 13 May 2014 14:19:04 +0900
Subject: [PATCHv2] mmc: dw_mmc: change to use recommended reset procedure
In-Reply-To: <1399945121-7387-1-git-send-email-sonnyrao@chromium.org>
References: <1399945121-7387-1-git-send-email-sonnyrao@chromium.org>
Message-ID: <073601cf6e6a$db71f0e0$9255d2a0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sonny Rao wrote:
> 
> This patch changes the fifo reset code to follow the reset procedure
> outlined in the documentation of Synopsys  Mobile storage host databook
> 7.2.13.
> 
> v2: Add Generic DMA support
>     per the documentation, move interrupt clear before wait
>     make the test for DMA host->use_dma rather than host->using_dma
>     add proper return values (although it appears no caller checks)

Above changes should be put after following '---'.

> 
> Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
> ---

Here.

- Kukjin

>  drivers/mmc/host/dw_mmc.c | 55
> ++++++++++++++++++++++++++++++++++++++++++++++-
>  drivers/mmc/host/dw_mmc.h |  1 +
>  2 files changed, 55 insertions(+), 1 deletion(-)
