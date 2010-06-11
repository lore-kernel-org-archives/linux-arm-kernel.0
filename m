From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 11 Jun 2010 22:44:05 +0800
Subject: [PATCH] USB: gadget: pxa2xx: allow -1 for invalid gpio
In-Reply-To: <89D837B3-BCDC-48A4-BBF9-B292AE55D7AB@workware.net.au>
References: <89D837B3-BCDC-48A4-BBF9-B292AE55D7AB@workware.net.au>
Message-ID: <AANLkTin54H3yGMx0aaEo1jJIOo4hWDQ0kQjGpwXzDHnF@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 21, 2010 at 2:30 PM, Steve Bennett <steveb@workware.net.au> wrote:
> gpio must be int, not u16, otherwise -1 isn't recognised
> by gpio_is_valid().
>
> Signed-off-by: Steve Bennett <steveb@workware.net.au>

This looks to have missed the last merge window, I'm picking this up
into the pxa tree.
