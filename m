From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 18 Jun 2012 17:34:27 -0700
Subject: [PATCH 1/2] serial/amba-pl011: use devm_* allocators
In-Reply-To: <1339940648-6847-1-git-send-email-linus.walleij@stericsson.com>
References: <1339940648-6847-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20120619003427.GA3114@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 17, 2012 at 03:44:08PM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This switches a bunch of allocation and remapping to use the
> devm_* garbage collected methods and cleans up the error
> path and remove() paths consequently.
> 
> devm_ioremap() is only in <linux/io.h> so fix up the
> erroneous <asm/*> include as well.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/tty/serial/amba-pl011.c |   20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> 

This patch doesn't apply, what tree did you make it against?

greg k-h
