From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 1 Jul 2013 08:42:17 -0300
Subject: [PATCH] ARM: mxs: Fix mxs_pm_init if CONFIG_PM undefined
In-Reply-To: <1372678590-8765-1-git-send-email-marex@denx.de>
References: <1372678590-8765-1-git-send-email-marex@denx.de>
Message-ID: <CAOMZO5Bk6ZCtK61p+qhmedFQ8gy6K2jHGCn-e5YTLhPC4nJ78Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 1, 2013 at 8:36 AM, Marek Vasut <marex@denx.de> wrote:
> In case the CONFIG_PM is not defined, the mxs_pm_init() from pm.c
> is not compiled and therefore mxs_pm_init() is not available. Make
> sure that the kernel builds even if CONFIG_PM is not defined.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>

Arnd has already sent a fix for this:
http://www.spinics.net/lists/arm-kernel/msg254288.html
