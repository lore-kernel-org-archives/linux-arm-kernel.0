From: romain.izard.pro@gmail.com (Romain Izard)
Date: Fri, 10 Mar 2017 16:30:20 +0100
Subject: [PATCH v1] usb: gadget: udc: atmel: Remove an unused local
 variable
In-Reply-To: <20170309170243.27388-1-romain.izard.pro@gmail.com>
References: <20170309170243.27388-1-romain.izard.pro@gmail.com>
Message-ID: <CAGkQfmOjrTv7OCAM3OmfO0z1B3bW69TxX_yn-Gz-VHa7gZfH1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-03-09 18:02 GMT+01:00 Romain Izard <romain.izard.pro@gmail.com>:
> The local variable ept_cfg is not used anymore in usba_ep_enable.
> Use ep->ept_cfg in the debug function to remove a warning when building
> with dynamic debug enabled.
>
> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
> Fixes: 741d2558bf0a ("usb: gadget: udc: atmel: Update endpoint allocation scheme")

Sorry for the noise, 4242820277b5 ("usb: gadget: udc: atmel: fix debug
output") in Greg KH's tree already fixed this.

-- 
Romain Izard
