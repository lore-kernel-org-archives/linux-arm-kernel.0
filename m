From: b32955@freescale.com (Huang Shijie)
Date: Tue, 17 Dec 2013 12:02:11 +0800
Subject: [PATCH v3 0/7] mtd: spi-nor: add a new framework for SPI NOR
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EA56ADC@DBDE04.ent.ti.com>
References: <1387184330-14448-1-git-send-email-b32955@freescale.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA56ADC@DBDE04.ent.ti.com>
Message-ID: <20131217040209.GA27091@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 04:08:33AM +0000, Gupta, Pekon wrote:
> 
> As much base code is copied from m25p90.c,
> Do you mind keeping the sign-offs of the original contributors of m25p80.c
> at-least in patches where much code is ported ?
I have added the lines in the spi-nor.c:

 " Cloned most of the code from the m25p80.c"

> This would at-least give some credit to original authors and contributors.
I do not change any authors information of m25p80.c.

If it is not enough?  Could you remind me what to do ?

thanks
Huang Shijie
