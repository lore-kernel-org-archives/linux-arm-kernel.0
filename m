From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 24 Oct 2014 14:21:01 +0200
Subject: [PATCH v5 2/4] gpio: vf610: add gpiolib/IRQ chip driver for Vybrid
In-Reply-To: <97db7732f2fc24402a5be56f5ba19f00b7e2c66a.1413488264.git.stefan@agner.ch>
References: <cover.1413488264.git.stefan@agner.ch>
 <97db7732f2fc24402a5be56f5ba19f00b7e2c66a.1413488264.git.stefan@agner.ch>
Message-ID: <CACRpkdYB8MEhSXiiRBbZeMdj_+ts9XU8VFy=sYM0wbe9qJznuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 16, 2014 at 9:47 PM, Stefan Agner <stefan@agner.ch> wrote:

> Add a gpiolib and IRQ chip driver for Vybrid ARM SoC using the
> Vybrid's GPIO and PORT module. The driver is instanced once per
> each GPIO/PORT module pair and handles 32 GPIO's.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Acked-by: Shawn Guo <shawn.guo@freescale.com>

Patch applied to the GPIO tree.

Yours,
Linus Walleij
