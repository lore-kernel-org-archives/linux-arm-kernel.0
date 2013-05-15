From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 May 2013 18:33:21 +0200
Subject: [PATCH 02/39] dmaengine: ste_dma40: Remove unnecessary call to
 d40_phy_cfg()
In-Reply-To: <1368611522-9984-3-git-send-email-lee.jones@linaro.org>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-3-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbWPLvPmJz_oHxFVJ9w+8XRJsVVD5v=6LyoDzpYA+JRHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 11:51 AM, Lee Jones <lee.jones@linaro.org> wrote:

> All configuration left in d40_phy_cfg() is runtime configurable and
> there is already a call into it from d40_runtime_config(), so let's
> rely on that.
>
> Acked-by: Vinod Koul <vnod.koul@intel.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

You forgot to update the commit message, but I saw that you
fixed what I asked for so I just went in and edited the commit message
and applied it.

Yours,
Linus Walleij
