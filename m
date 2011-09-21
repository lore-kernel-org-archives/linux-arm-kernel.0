From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 21 Sep 2011 12:31:48 +0200
Subject: [rtc-linux] [PATCH 46/57] rtc: irq: Remove IRQF_DISABLED
In-Reply-To: <1316597339-29861-47-git-send-email-yong.zhang0@gmail.com>
References: <1316597339-29861-1-git-send-email-yong.zhang0@gmail.com>
	<1316597339-29861-47-git-send-email-yong.zhang0@gmail.com>
Message-ID: <20110921103148.GB1966@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 21, 2011 at 05:28:47PM +0800, Yong Zhang wrote:
> Since commit [c58543c8: genirq: Run irq handlers with interrupts disabled],
> We run all interrupt handlers with interrupts disabled
> and we even check and yell when an interrupt handler
> returns with interrupts enabled (see commit [b738a50a:
> genirq: Warn when handler enables interrupts]).
> 
> So now this flag is a NOOP and can be removed.
> 
> Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110921/9fdefceb/attachment.sig>
