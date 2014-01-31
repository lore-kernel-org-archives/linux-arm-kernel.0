From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 31 Jan 2014 08:57:24 +0100
Subject: [PATCH v2 2/2] at91: pinctrl: use gpiolib API to mark a GPIO used
 as an IRQ
In-Reply-To: <1390473478-5591-3-git-send-email-jjhiblot@traphandler.com>
References: <1390473478-5591-1-git-send-email-jjhiblot@traphandler.com>
 <1390473478-5591-3-git-send-email-jjhiblot@traphandler.com>
Message-ID: <CACRpkdYjxxYqJf_f0U5WEQuGpUB0Z+d+23i12yT6owZ=enRWaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 23, 2014 at 11:37 AM, Jean-Jacques Hiblot
<jjhiblot@traphandler.com> wrote:

> When an IRQ is started on a GPIO line, mark this GPIO as IRQ in
> the gpiolib so we can keep track of the usage centrally.
>
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>

Thanks!

Patch applied.

Yours,
Linus Walleij
