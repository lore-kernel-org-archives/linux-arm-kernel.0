From: b32955@freescale.com (Huang Shijie)
Date: Wed, 5 Mar 2014 13:45:22 +0800
Subject: [PATCH v5 1/8] mtd: spi-nor: copy the SPI NOR commands to a new
 header file
In-Reply-To: <201403050443.19529.marex@denx.de>
References: <1393238262-8622-1-git-send-email-b32955@freescale.com>
 <201403042313.14353.marex@denx.de> <5316932C.5040405@freescale.com>
 <201403050443.19529.marex@denx.de>
Message-ID: <5316B9F2.8050301@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2014?03?05? 11:43, Marek Vasut ??:
> Why didn't you keep it like that? Was there some reason for that ?
http://marc.info/?l=linux-arm-kernel&m=138545182232220&w=4

Pekon suggestted  do not touch the m25p80.c.
So i just copy these commands to a new header.
Anyway, it's really not an important issue for me. :)



thanks
Huang Shijie
