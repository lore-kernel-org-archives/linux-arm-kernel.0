From: b32955@freescale.com (Huang Shijie)
Date: Mon, 13 Aug 2012 10:35:14 +0800
Subject: [PATCH v4] mtd: gpmi: add NAND write verify support
In-Reply-To: <201208122114.46901.marex@denx.de>
References: <1344737275-18342-1-git-send-email-shijie8@gmail.com>
 <201208111610.45107.marex@denx.de>
 <CAMiH66GopNVeKPRQn+KfwRHUoM-Lv8WitX0zAS=Vi=8QAvS-Pw@mail.gmail.com>
 <201208122114.46901.marex@denx.de>
Message-ID: <502867E2.8020405@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2012?08?13? 03:14, Marek Vasut ??:
> Don't forget the malloc header and padding around malloc()'d space. So you're
> behind the 2 * PAGESIZE anyway.
>
sorry, I misunderstood your meaning. My meaning is even the SLUB maybe 
costs some extra memory, it still save much memory
then we use the devm_kzalloc().

thanks
Huang Shijie
