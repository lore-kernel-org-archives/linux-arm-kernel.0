From: torfl6749@gmail.com (Torsten Fleischer)
Date: Tue, 17 Feb 2015 12:52:17 +0100
Subject: [PATCH 0/2] dma: at_hdmac: Fix residue calculation and add mem to
 mem sg support
In-Reply-To: <1423387744-2410-1-git-send-email-torfl6749@gmail.com>
References: <1423387744-2410-1-git-send-email-torfl6749@gmail.com>
Message-ID: <CANZ4BrQf7dMGP+BHkMGjPE_hp7My35FA+Gt_CUKCV_-aizgbRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-02-08 10:29 GMT+01:00 Torsten Fleischer <torfl6749@gmail.com>:
> From: Torsten Fleischer <torfl6749@gmail.com>
>
> This series fixes the calculation of the residual bytes and adds support for
> memory to memory scatter-gather transfers.
>
> Torsten Fleischer (2):
>   dma: at_hdmac: Fix calculation of the residual bytes
>   dma: at_hdmac: Add support for memory to memory sg transfers
>
>  drivers/dma/at_hdmac.c      | 316 ++++++++++++++++++++++++++++++++------------
>  drivers/dma/at_hdmac_regs.h |  11 +-
>  2 files changed, 233 insertions(+), 94 deletions(-)
>
> --
> 2.1.4
>
Any comments about this series?
