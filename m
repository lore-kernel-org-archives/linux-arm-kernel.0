From: marex@denx.de (Marek Vasut)
Date: Tue, 4 Mar 2014 23:13:14 +0100
Subject: [PATCH v5 1/8] mtd: spi-nor: copy the SPI NOR commands to a new
 header file
In-Reply-To: <1393238262-8622-2-git-send-email-b32955@freescale.com>
References: <1393238262-8622-1-git-send-email-b32955@freescale.com>
 <1393238262-8622-2-git-send-email-b32955@freescale.com>
Message-ID: <201403042313.14353.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, February 24, 2014 at 11:37:35 AM, Huang Shijie wrote:
> This patch adds a new header :spi-nor.h,
> and copies all the SPI NOR commands and relative macros into this new
> header.
> 
> This hearder can be used by the m25p80.c and other spi-nor controller,
> such as Freescale's Quadspi.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>

Please keep me on CC ;-)

I honestly have to wonder ... why do you not 'move' these definitions instead of 
copying them ?

Best regards,
Marek Vasut
