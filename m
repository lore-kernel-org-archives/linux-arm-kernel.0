From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 6 Aug 2012 14:37:52 +0000
Subject: [PATCH] ARM: integrator: use clk_prepare_enable() for timer
In-Reply-To: <CACRpkdZqaJhCYuW+3WYacjuwJ3zshAexDqLSUJgCCDzVS+=X7g@mail.gmail.com>
References: <1344199075-4111-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdZqaJhCYuW+3WYacjuwJ3zshAexDqLSUJgCCDzVS+=X7g@mail.gmail.com>
Message-ID: <201208061437.52415.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 05 August 2012, Linus Walleij wrote:
> On Sun, Aug 5, 2012 at 10:37 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> > The Integrator timer is using the clock framework to get the
> > timer frequency, but missed to prepare the clock before enabling.
> >
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Arnd, Olof,
> 
> If this patch looks OK to you I request that you apply it alone, no pull
> requests, too much hazzle for a single patch...
> 

Applying a patch is fine, but please explain which version(s) to apply
this to? Is it a regression in v3.6, or should it be backported to
earlier versions too?

	Arnd
