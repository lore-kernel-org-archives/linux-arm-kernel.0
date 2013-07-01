From: marex@denx.de (Marek Vasut)
Date: Mon, 1 Jul 2013 13:45:33 +0200
Subject: [PATCH] ARM: mxs: Fix mxs_pm_init if CONFIG_PM undefined
In-Reply-To: <CAOMZO5Bk6ZCtK61p+qhmedFQ8gy6K2jHGCn-e5YTLhPC4nJ78Q@mail.gmail.com>
References: <1372678590-8765-1-git-send-email-marex@denx.de>
 <CAOMZO5Bk6ZCtK61p+qhmedFQ8gy6K2jHGCn-e5YTLhPC4nJ78Q@mail.gmail.com>
Message-ID: <201307011345.33911.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Fabio Estevam,

> On Mon, Jul 1, 2013 at 8:36 AM, Marek Vasut <marex@denx.de> wrote:
> > In case the CONFIG_PM is not defined, the mxs_pm_init() from pm.c
> > is not compiled and therefore mxs_pm_init() is not available. Make
> > sure that the kernel builds even if CONFIG_PM is not defined.
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Shawn Guo <shawn.guo@linaro.org>
> 
> Arnd has already sent a fix for this:
> http://www.spinics.net/lists/arm-kernel/msg254288.html

Ok, thanks. Will this hit 3.10 in any subsequent update?

Best regards,
Marek Vasut
