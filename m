From: b32955@freescale.com (Huang Shijie)
Date: Wed, 5 Mar 2014 10:59:56 +0800
Subject: [PATCH v5 1/8] mtd: spi-nor: copy the SPI NOR commands to a new
 header file
In-Reply-To: <201403042313.14353.marex@denx.de>
References: <1393238262-8622-1-git-send-email-b32955@freescale.com>
 <1393238262-8622-2-git-send-email-b32955@freescale.com>
 <201403042313.14353.marex@denx.de>
Message-ID: <5316932C.5040405@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2014?03?05? 06:13, Marek Vasut ??:
> Please keep me on CC;-)
sorry, My fault :(


> I honestly have to wonder ... why do you not 'move' these definitions instead of
> copying them ?
>
In the first version , i did so:
http://marc.info/?l=linux-arm-kernel&m=138544933522564&w=2

if I need to resend the patch set again, i can change to move the 
commands to the new header.

thanks
Huang Shijie
