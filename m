From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Sun, 7 Apr 2013 15:20:54 +0530
Subject: [PATCH 0/2] Support device_prep_dma_sg for pl330
In-Reply-To: <1364904076-3130-1-git-send-email-chanho61.park@samsung.com>
References: <1364904076-3130-1-git-send-email-chanho61.park@samsung.com>
Message-ID: <CABb+yY1NA0VDwuHYtoGSA6L80cyjL2TP_kWP89EdMqvA6fQHiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 2, 2013 at 5:31 PM, Chanho Park <chanho61.park@samsung.com> wrote:
> This patchset support device_prep_dma_sg functionality for pl330 dmaengine
> driver. The prep_dma_sg function prepares descriptors to transfer between src
> and dest memory which consists of scatter/gather list. The patchset contains
> code clean-up to eliminate duplications.
>
> Chanho Park (2):
>   dma: pl330: split off common code to give back descriptors
>   dma: pl330: add pl330_prep_dma_sg to transfer from sglist to sglist
>
>  drivers/dma/pl330.c |  209 ++++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 157 insertions(+), 52 deletions(-)
>
Acked-by : Jassi Brar <jassisinghbrar@gmail.com>
