From: marex@denx.de (Marek Vasut)
Date: Wed, 5 Mar 2014 04:43:19 +0100
Subject: [PATCH v5 1/8] mtd: spi-nor: copy the SPI NOR commands to a new
 header file
In-Reply-To: <5316932C.5040405@freescale.com>
References: <1393238262-8622-1-git-send-email-b32955@freescale.com>
 <201403042313.14353.marex@denx.de> <5316932C.5040405@freescale.com>
Message-ID: <201403050443.19529.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, March 05, 2014 at 03:59:56 AM, Huang Shijie wrote:
> ? 2014?03?05? 06:13, Marek Vasut ??:
> > Please keep me on CC;-)
> 
> sorry, My fault :(
> 
> > I honestly have to wonder ... why do you not 'move' these definitions
> > instead of copying them ?
> 
> In the first version , i did so:
> http://marc.info/?l=linux-arm-kernel&m=138544933522564&w=2
> 
> if I need to resend the patch set again, i can change to move the
> commands to the new header.

Why didn't you keep it like that? Was there some reason for that ?

Best regards,
Marek Vasut
