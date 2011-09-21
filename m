From: peter.ujfalusi@ti.com (Ujfalusi, Peter)
Date: Wed, 21 Sep 2011 13:21:17 +0300
Subject: [PATCH 53/57] sound: irq: Remove IRQF_DISABLED
In-Reply-To: <1316597339-29861-54-git-send-email-yong.zhang0@gmail.com>
References: <1316597339-29861-1-git-send-email-yong.zhang0@gmail.com>
	<1316597339-29861-54-git-send-email-yong.zhang0@gmail.com>
Message-ID: <CAPo=G1zGu7zf2KTKmzZynWQ9X3DS+SjKLFuZkjSQ5KsSuZ6Dgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 21, 2011 at 12:28 PM, Yong Zhang <yong.zhang0@gmail.com> wrote:
> Since commit [c58543c8: genirq: Run irq handlers with interrupts disabled],
> We run all interrupt handlers with interrupts disabled
> and we even check and yell when an interrupt handler
> returns with interrupts enabled (see commit [b738a50a:
> genirq: Warn when handler enables interrupts]).
>
> So now this flag is a NOOP and can be removed.
>
> Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
