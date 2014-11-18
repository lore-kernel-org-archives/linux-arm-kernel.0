From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Tue, 18 Nov 2014 15:02:40 +0100
Subject: [PATCH 2/2] ARM: dts: Add missing irq pinctrl for max77686 on
 smdk5250
In-Reply-To: <1416312509-11530-2-git-send-email-yadi.brar@samsung.com>
References: <1416312509-11530-1-git-send-email-yadi.brar@samsung.com>
 <1416312509-11530-2-git-send-email-yadi.brar@samsung.com>
Message-ID: <CABxcv=moHWKCPsmOkk5w=L8EZeke+8TzPkW+vERKWBc5qRNb=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Yadwinder,

On Tue, Nov 18, 2014 at 1:08 PM, Yadwinder Singh Brar
<yadi.brar@samsung.com> wrote:
> This patch adds pinctrl configuration for using configuring gpx3-2 as an
> external interrupt from max77686. Though max77686 RTC is enabled and gets
> probed by default, it doesnt work as its unable to get interrupt.
>

I'm not familiar with this board but the patch looks good to me
assuming the IRQ is the correct one.

Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
