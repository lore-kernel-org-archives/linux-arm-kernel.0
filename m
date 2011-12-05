From: wim@iguana.be (Wim Van Sebroeck)
Date: Mon, 5 Dec 2011 20:13:48 +0100
Subject: [PATCH] [WATCHDOG] move coh901327 state holders
In-Reply-To: <CACRpkdb9+ZsnXFbjJXg-=amnVwYu_EyKftYxRptjq8SDoqurvA@mail.gmail.com>
References: <1317631978-22818-1-git-send-email-linus.walleij@stericsson.com>
 <CACRpkdb9+ZsnXFbjJXg-=amnVwYu_EyKftYxRptjq8SDoqurvA@mail.gmail.com>
Message-ID: <20111205191348.GU23376@infomag.iguana.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

> > From: Linus Walleij <linus.walleij@linaro.org>
> >
> > The state holders used in the PM path of the drivers report as
> > unused variables when compiling without CONFIG_PM so let's
> > move them inside CONFIG_PM.
> >
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Ping on this, Wim is this patch OK?

Patch is OK and has been added to the linux-next branch of the watchdog tree.

Kind regards,
Wim.
