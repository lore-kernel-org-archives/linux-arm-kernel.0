From: joe@perches.com (Joe Perches)
Date: Tue, 10 May 2011 17:28:51 -0700
Subject: [PATCH 2/4] pinmux: add a driver for the U300 pinmux
In-Reply-To: <BANLkTinnPWu9TZ72xdnXayrG0QYF+0mMBg@mail.gmail.com>
References: <1304363798-30409-1-git-send-email-linus.walleij@stericsson.com>
	<1304365233.7792.42.camel@Joe-Laptop>
	<BANLkTinnPWu9TZ72xdnXayrG0QYF+0mMBg@mail.gmail.com>
Message-ID: <1305073731.19586.175.camel@Joe-Laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-05-11 at 02:17 +0200, Linus Walleij wrote:
> 2011/5/2 Joe Perches <joe@perches.com>:
> > On Mon, 2011-05-02 at 21:16 +0200, Linus Walleij wrote:
> > []
> >> diff --git a/drivers/pinmux/pinmux-u300.c b/drivers/pinmux/pinmux-u300.c
> >> +++ b/drivers/pinmux/pinmux-u300.c
> >> +struct u300_pin_desc {
> >> +     unsigned number;
> >> +     char *name;
> > const char *name?
> Thanks, fixed!
> Can I have your reviewed-by for this patch given I fixed that?

Hi Linus.

I've only looked at the code not compiled, used or tested it
and so I think my sign-off isn't particularly valuable.

But your design and implementation seem sensible.

Anyway if you want for the whole series:

Reviewed-but-not-compiled-used-or-tested-by: Joe Perches <joe@perches.com>

(that way I won't get copied by get_maintainer.pl ;)

cheers, Joe
