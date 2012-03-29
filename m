From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 29 Mar 2012 13:43:37 +0000
Subject: [PATCH] ARM: ux500: fix compile error in new timer code
In-Reply-To: <CACRpkdbi3JM_iGmWiV9pF0Pff+p9_4taw1aQOpgzprgrnLFdWQ@mail.gmail.com>
References: <1332931787-27741-1-git-send-email-lee.jones@linaro.org>
 <CACRpkdbi3JM_iGmWiV9pF0Pff+p9_4taw1aQOpgzprgrnLFdWQ@mail.gmail.com>
Message-ID: <201203291343.37298.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 28 March 2012, Linus Walleij wrote:
> On Wed, Mar 28, 2012 at 12:49 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > This patch fixes the errors below:
> >
> > error: implicit declaration of function ?pr_err?
> > error: implicit declaration of function ?BUG?
> >
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> I'll apply and funnel to ARM-SoC when I'm back in Europe unless
> you want to push it to Arnd/Olof directly.

I've applied it now to the fixes branch, as I'm collecting other patches
as well.

	Arnd
