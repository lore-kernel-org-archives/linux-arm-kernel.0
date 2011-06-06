From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 6 Jun 2011 09:50:59 -0300
Subject: [PATCH v2 1/2] ARM: mx5/mx51_3ds: Fix build due to missing header
	and wrong define
In-Reply-To: <20110606074258.GX23771@pengutronix.de>
References: <1307212185-18184-1-git-send-email-festevam@gmail.com>
	<20110606074258.GX23771@pengutronix.de>
Message-ID: <BANLkTik9MQrJt-7Gkdw_Cpwi0ZXo3RScTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Mon, Jun 6, 2011 at 4:42 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
...
> I squashed these two patches into the original commit which breaks the
> build. Can I have you ack for the following?
>
> 8<------------------------------------------------------
> [PATCH] ARM i.MX: get rid of wrong MXC_INTERNAL_IRQ usage
>
> There are several occurences where MXC_INTERNAL_IRQ is
> assumed to be the start of the gpio interrupts. It was never
> meant this way. Replace these with gpio_to_irq.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Acked-by: Fabio Estevam <fabio.estevam@freescale.com>

Regards,

Fabio Estevam
