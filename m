From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 5 Feb 2018 12:56:04 +0100
Subject: [RESEND][PATCH] video: fbdev: atmel_lcdfb: convert to use GPIO
 descriptors
In-Reply-To: <20180205084755.6011-1-ludovic.desroches@microchip.com>
References: <20180205084755.6011-1-ludovic.desroches@microchip.com>
Message-ID: <CACRpkdajUDNkODAGU=6SHRJz-q5-+sFRy7Qi9=QLc-HF1NEHWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 5, 2018 at 9:47 AM, Ludovic Desroches
<ludovic.desroches@microchip.com> wrote:

> Use GPIO descriptors instead of relying on the old method.
>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Ah there it is :D
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

PS: why not move it all over to use DRI/DRM/KMS? It's becoming
easier and easier.

Yours,
Linus Walleij
