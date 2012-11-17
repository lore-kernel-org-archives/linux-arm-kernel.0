From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 17 Nov 2012 19:41:56 +0100
Subject: [PATCH] ARM: integrator: use BUG_ON where possible
In-Reply-To: <201211122044.13663.arnd@arndb.de>
References: <1352406191-14303-1-git-send-email-sasha.levin@oracle.com>
 <1352406191-14303-6-git-send-email-sasha.levin@oracle.com>
 <201211122044.13663.arnd@arndb.de>
Message-ID: <CACRpkdZeM_FBGSa+UcH6GTK-Q7ekHbZO7Az7wQibfuFYqLFFhA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 12, 2012 at 9:44 PM, Arnd Bergmann <arnd@arndb.de> wrote:

>> Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
>
> Linus Walleij is doing most of the integrator work these days, maybe he
> wants to apply the patch.
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

OK I'll apply it to my stash and submit a pull request to
simplify things.

I could split this into its own topic but with noone else changing
anything orthogonally on the Integrator I don't know if it's really
worth it, probably it's just better to take the stuff I sent yesterday
and a patch I made this evening and request it all to be pulled
at once.

Yours,
Linus Walleij
