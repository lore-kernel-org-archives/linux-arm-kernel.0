From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 27 Mar 2013 14:26:57 +0100
Subject: [PATCH v2 1/2] gpio: mvebu: add dbg_show function
In-Reply-To: <1364136330-28193-2-git-send-email-simon.guinot@sequanux.org>
References: <1364136330-28193-1-git-send-email-simon.guinot@sequanux.org>
 <1364136330-28193-2-git-send-email-simon.guinot@sequanux.org>
Message-ID: <CACRpkdZNn-27fpbzrBx7WhUYEVxdLwjkm+uSnuNzSPo1R3Bvcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 24, 2013 at 3:45 PM, Simon Guinot <simon.guinot@sequanux.org> wrote:

> This patch adds a dedicated dbg_show function to the gpio-mvebu driver.
> In addition to the generic gpiolib informations, this function displays
> informations related with the specific Marvell registers (blink enable,
> data in polarity, interrupt masks and cause).
>
> Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> ---
> Changes for v2:
>  - In order to match registers type, swith msk type to u32.

Looks helpful.

Patch applied.

Thanks!
Linus Walleij
