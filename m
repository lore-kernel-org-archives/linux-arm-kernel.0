From: linux@bohmer.net (Remy Bohmer)
Date: Fri, 29 Jan 2010 18:04:19 +0100
Subject: [patch v2 1/2] at91_udc.c read_fifo timing issue
In-Reply-To: <20100129162155.709756286@gmail.com>
References: <20100129162029.998540038@gmail.com>
	<20100129162155.709756286@gmail.com>
Message-ID: <3efb10971001290904p74b1919aif8ff013f050123a9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Harro,

2010/1/29 Harro Haan <hrhaan@gmail.com>:
> This solves the read_fifo timing issue for example seen with CDC Ethernet.
> See the comments below for more info.
>
> Signed-off-by: Harro Haan <hrhaan@gmail.com>
> ---
> ?drivers/usb/gadget/at91_udc.c | ? 46 ++++++++++++++++++++++++++++++++++++++----
> ?1 file changed, 42 insertions(+), 4 deletions(-)
>
Acked-by: Remy Bohmer <linux@bohmer.net>
