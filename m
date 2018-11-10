From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Sat, 10 Nov 2018 12:45:09 +0100
Subject: [PATCH 0/3] Fix MODULE_LICENSE of bcm2835 drivers
In-Reply-To: <1540292769-5905-1-git-send-email-stefan.wahren@i2se.com>
References: <1540292769-5905-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <B176A2C1-D221-4F36-9A61-571EF5AB6FEB@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 23.10.2018, at 13:06, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> 
> In preparation of a treewide switch of all bcm2835 drivers to SPDX tags,
> we need to make sure that the license text and MODULE_LICENSE matches.
> 
> This series starts sooner than usual to have more time to collect the authors
> ACK.
> 
> Stefan Wahren (3):
>  clk: bcm2835: make license text and module license match
>  dma: bcm2835: make license text and module license match
>  spi: bcm2835: make license text and module license match
> 
> drivers/clk/bcm/clk-bcm2835-aux.c | 2 +-
> drivers/clk/bcm/clk-bcm2835.c     | 2 +-
> drivers/dma/bcm2835-dma.c         | 2 +-
> drivers/spi/spi-bcm2835.c         | 2 +-
> drivers/spi/spi-bcm2835aux.c      | 2 +-
> 5 files changed, 5 insertions(+), 5 deletions(-)
> 

Acked-by: Martin Sperl <kernel@martin.sperl.org>
