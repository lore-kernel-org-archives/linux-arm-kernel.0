From: b32955@freescale.com (Huang Shijie)
Date: Tue, 26 Nov 2013 16:53:43 +0800
Subject: [PATCH 1/4] mtd: spi-nor: move the SPI NOR commands to a new
 header file
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EA4EC81@DBDE04.ent.ti.com>
References: <1385447575-23773-1-git-send-email-b32955@freescale.com>
 <1385447575-23773-2-git-send-email-b32955@freescale.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA4EC81@DBDE04.ent.ti.com>
Message-ID: <52946197.5050104@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pekon:
> (1)
> It's better to take all Flash vendor specific opcodes from DT..
firstly, some arch may does not support the DT, such as x86.

second, it makes people crazy if we put the opcodes in the DT :)
> With new framework we should do away with macros for each vendor,
> instead let each board file provide this information based on flash device
> which is mounted on it.
>
> (2)
> And also, I suggest not to touch m25p80 in anyway, bcoz it stable driver
> used by many. So unless spi-nor framework is accepted and is stable we
> m25p80 should continue working as it is.
> Thus your patches should be independent of any existing driver or other
> frameworks. This way it might get accepted fast. Then later you can provide
> a way to attach m25p80 to spi-nor framework.
> Thoughts ?
the merge window is closed not long ago, and we have rc1 now.

Isn't it the BEST time to change the m25p80?

thanks
Huang Shijie
