From: eric.y.miao@gmail.com (Eric Miao)
Date: Sat, 23 Jun 2012 20:52:04 +0800
Subject: [PATCH] usb: gadget: pxa25x_udc: compile fix
In-Reply-To: <1340338452-885-1-git-send-email-steveb@workware.net.au>
References: <1340338452-885-1-git-send-email-steveb@workware.net.au>
Message-ID: <CAMPhdO8TVi720Lm267pDe=aT1Ru8iQAC0Y=d+v7A3Lku9nQ3fA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 22, 2012 at 12:14 PM, Steve Bennett <steveb@workware.net.au> wrote:
> Signed-off-by: Steve Bennett <steveb@workware.net.au>

Acked-by: Eric Miao <eric.y.miao@gmail.com>

> ---
> ?drivers/usb/gadget/pxa25x_udc.h | ? ?2 +-
> ?1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/gadget/pxa25x_udc.h b/drivers/usb/gadget/pxa25x_udc.h
> index 861f4df..2eca1e7 100644
> --- a/drivers/usb/gadget/pxa25x_udc.h
> +++ b/drivers/usb/gadget/pxa25x_udc.h
> @@ -225,7 +225,7 @@ dump_state(struct pxa25x_udc *dev)
> ? ? ? ? ? ? ? ?dev->stats.read.bytes, dev->stats.read.ops);
>
> ? ? ? ?for (i = 1; i < PXA_UDC_NUM_ENDPOINTS; i++) {
> - ? ? ? ? ? ? ? if (dev->ep [i].desc == NULL)
> + ? ? ? ? ? ? ? if (dev->ep[i].ep.desc == NULL)
> ? ? ? ? ? ? ? ? ? ? ? ?continue;
> ? ? ? ? ? ? ? ?DMSG ("udccs%d = %02x\n", i, *dev->ep->reg_udccs);
> ? ? ? ?}
> --
> 1.7.10
>
