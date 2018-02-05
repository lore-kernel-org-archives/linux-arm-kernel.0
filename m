From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 5 Feb 2018 12:54:29 +0100
Subject: [PATCH] video: fbdev: convert to use GPIO descriptors
In-Reply-To: <20180205082335.5727-1-ludovic.desroches@microchip.com>
References: <20180205082335.5727-1-ludovic.desroches@microchip.com>
Message-ID: <CACRpkdbg1gXJigiPp9Ee0D0gyif-crsuBf9R93e9jJ-mjDkLug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 5, 2018 at 9:23 AM, Ludovic Desroches
<ludovic.desroches@microchip.com> wrote:

> Use GPIO descriptors instead of relying on the old method.
>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>

The subject should probably indicate that you're patching the
Atmel driver. Anyways:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for doing this.
Linus Walleij
