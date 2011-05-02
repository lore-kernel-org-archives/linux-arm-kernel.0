From: joe@perches.com (Joe Perches)
Date: Mon, 02 May 2011 12:40:33 -0700
Subject: [PATCH 2/4] pinmux: add a driver for the U300 pinmux
In-Reply-To: <1304363798-30409-1-git-send-email-linus.walleij@stericsson.com>
References: <1304363798-30409-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1304365233.7792.42.camel@Joe-Laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-05-02 at 21:16 +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
[]
> diff --git a/drivers/pinmux/pinmux-u300.c b/drivers/pinmux/pinmux-u300.c
> +++ b/drivers/pinmux/pinmux-u300.c
> +struct u300_pin_desc {
> +	unsigned number;
> +	char *name;

const char *name?
