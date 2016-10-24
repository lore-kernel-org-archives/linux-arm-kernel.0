From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Oct 2016 02:56:39 +0200
Subject: [PATCH 1/2] gpio: mxs: use enable/disable regs to (un)mask irqs
In-Reply-To: <20161021131138.10467-2-s.hauer@pengutronix.de>
References: <20161021131138.10467-1-s.hauer@pengutronix.de>
 <20161021131138.10467-2-s.hauer@pengutronix.de>
Message-ID: <CACRpkdYkKPMvVcvxzvAsMvaNUADc0e0GOMEFokzgPips=003Bg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 21, 2016 at 3:11 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:

> The mxs gpio controller does not only have a mask register to mask
> interrupts, but also enable/disable registers. Use the enable/disable
> registers rather than the mask register. This does not have any
> advantage for now, but makes the next patch simpler.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Patch applied with Marek's review tag.

Yours,
Linus Walleij
