From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 12 Feb 2014 17:24:41 +0100
Subject: [PATCH 10/17] i2c: i2c-nomadik: deprecate class based
 instantiation
In-Reply-To: <1392026654-5343-11-git-send-email-wsa@the-dreams.de>
References: <1392026654-5343-1-git-send-email-wsa@the-dreams.de>
 <1392026654-5343-11-git-send-email-wsa@the-dreams.de>
Message-ID: <CACRpkdYVENZGXryqL_R4c8bGzb7yEYAcK0bbVrnVuq7dtNxj7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 11:04 AM, Wolfram Sang <wsa@the-dreams.de> wrote:

> Warn users that class based instantiation is going away soon in favour
> of more robust probing and faster bootup times.
>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> Cc: Alessandro Rubini <rubini@unipv.it>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> ---
>
> This patch is a suggestion. Looking for an ack by someone who actually uses
> the driver.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
