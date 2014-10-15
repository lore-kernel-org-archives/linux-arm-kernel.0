From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 Oct 2014 09:27:35 +0200
Subject: [PATCH v4 2/4] gpio: vf610: add gpiolib/IRQ chip driver for Vybrid
In-Reply-To: <d978829094e6a287415dc1baeabb0aed2799aafc.1411731755.git.stefan@agner.ch>
References: <cover.1411731755.git.stefan@agner.ch>
 <d978829094e6a287415dc1baeabb0aed2799aafc.1411731755.git.stefan@agner.ch>
Message-ID: <CACRpkdY2m+rvKzHGcZ8b=JMBCWQfjj_Bfucu4hFNGpianz4TJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 26, 2014 at 1:57 PM, Stefan Agner <stefan@agner.ch> wrote:

> Add a gpiolib and IRQ chip driver for Vybrid ARM SoC using the
> Vybrid's GPIO and PORT module. The driver is instanced once per
> each GPIO/PORT module pair and handles 32 GPIO's.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Acked-by: Shawn Guo <shawn.guo@freescale.com>

I'd like to apply this after the merge window, can you
please rebase it to my GPIO tree on the "devel" branch
or use Torvalds' HEAD?

Yours,
Linus Walleij
