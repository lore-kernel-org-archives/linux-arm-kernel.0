From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 22 Nov 2012 08:44:33 +0100
Subject: [PATCH 1/6] DMA: AT91: Serial: Add parameter for serial dma use
In-Reply-To: <50ADD70B.6070801@atmel.com>
References: <1351501754-25028-1-git-send-email-elen.song@atmel.com>
 <1351501773-29024-1-git-send-email-elen.song@atmel.com>
 <20121029114221.GA31214@game.jcrosoft.org>
 <508F7629.2040905@atmel.com> <50ADD70B.6070801@atmel.com>
Message-ID: <20121122074433.GZ4398@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15:40 Thu 22 Nov     , Elen Song wrote:
> On 2012-10-30 14:39, Elen Song wrote:
> >On 2012-10-29 19:42, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >>On 17:09 Mon 29 Oct     , Elen Song wrote:
> >>>Signed-off-by: Elen Song <elen.song@atmel.com>
> >>>---
> >>>  arch/arm/mach-at91/include/mach/board.h |    2 ++
> >>>  drivers/tty/serial/atmel_serial.c       |    1 +
> >>>  include/linux/platform_data/dma-atmel.h |   10 ++++++++++
> >>>  3 files changed, 13 insertions(+)
> >>you will have to rebase this over a clean if the platofrm_data
> >>I'll send today
> >>or tomorrow that will move all the platform_data to inclide/linux
> >
> >ok, please cc me in the mail list.
> Hi JC:
> 
>     any more feedback ?
no time finish to prepare the 3.8 will have to wait after

Best Regards,
J.
